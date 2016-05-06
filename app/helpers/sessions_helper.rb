module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    user.update_attribute(:remember_token, user.remember_token)
    cookies.permanent[:remember_token] = user.remember_token
    @current_user = user
  end

  # Logs out the current user.
  def log_out
    cookies.delete(:remember_token)
    @current_user = nil
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Set current user using a Virtual attribute
  def current_user=(user)
    @current_user = user
  end

  # Returns the current user
  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token])        
  end

end
