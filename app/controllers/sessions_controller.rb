class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: session_params[:email], password: session_params[:password])
    return redirect_to new_session_path unless user

    session[:user_id] = user.id
    redirect_to posts_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private
  def session_params
    params.fetch(:session, {})
  end
end
