class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email_or_username]) || 
           User.find_by(username: params[:email_or_username])

    # Tried a WHERE clause
    # https://guides.rubyonrails.org/active_record_querying.html#or-conditions
    #
    # NOTES: It returns an array of results so we need to pull off the first result
    #  whereas the find_by only pull back one. 
    # user = User.where(email: params[:email_or_username]).or(User.where(username: params[:email_or_username])).first
    # user = User.where(['email = ? or username = ?', params[:email_or_username], params[:email_or_username]]).first
    # user = User.where(['email = :eu or username = :eu', { eu: params[:email_or_username] }]).first

    # `user && user.some_method` can be converted using the safe navigation
    # operator `&.`
    # TODO: Which version of Ruby introduces this operator?
    if user&.authenticate(params[:password])
      # Session cookie notes from the course:
      #
      #  - The session cookie expires when the browser is closed.
      #  - The session cookie is limited to 4kb in size. So avoid storing
      #    large objects in the session, and instead store an object's id.
      #    Then use that id to look up the object in the database, as we did
      #    with the User object.
      #  - The session cookie can't be forged by a hacker. It's cryptographically
      #    signed to make it tamper-proof, and Rails will reject the cookie
      #    if it has been altered in any way. The session cookie is also encrypted,
      #    so you can't even read what's inside the session cookie. That prevents
      #    a malicious person from trying to impersonate a signed-in user by
      #    changing the user id in the session, for example.
      #  - That being said, you should never store sensitive information such
      #    as a password in a session!
      #
      # TODO: How would you store "session" data that persists beyond a closed brower
      #  window?
      session[:user_id] = user.id
      redirect_to session[:intended_url] || user, notice: "Welcome back, #{user.name}!"
      session[:intended_url] = nil
    else
      # We need .now so it shows with this request, otherwise it won't be
      # available until the next request. (I believe this is because of the
      # call to render and not something like a redirect)
      # TODO: Confirm this ☝🏻
      flash.now[:alert] = 'Invalid email/password combination.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    # see_other status to make sure the redirect is a GET request and not remain a DELETE
    redirect_to movies_url, status: :see_other, notice: "You're now signed out!"
  end
end
