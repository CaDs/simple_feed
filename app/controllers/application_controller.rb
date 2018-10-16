class ApplicationController < ActionController::Base
  before_action :set_user

  def auth_user
    return redirect_to new_session_url unless session[:user_id].present?
  end
  
  def set_user
    @user = User.find(session[:user_id])  if session[:user_id].present?
  end
end
