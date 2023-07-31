class ApplicationController < ActionController::Base
  add_flash_types(:danger)
  helper_method :current_user, :current_user?, :current_user_admin?

  private

  def require_signin
    # return if current_user
    #
    # redirect_to new_session_url, alert: 'Please sign in first!'
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: 'Please sign in first!'
    end
  end

  def require_admin
    redirect_to root_url, alert: 'Unauthorized access!' unless current_user_admin?
  end

  def current_user
    # Memoize the current user.
    # FIXME: How do I unset the current user after log OUT?
    @current_user ||= User.find_by(id: session[:user_id])
    # 'find' raises an exception when the record is not found and 'find_by' returns nil in that case
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def current_user_admin?
    # TODO: When did the 'chained nil-safe operator' enter Ruby?
    current_user&.admin?
  end
end
