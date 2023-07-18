module ApplicationHelper
  def current_user
    # Memoize the current user.
    # FIXME: How do I unset the current user after log OUT?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
