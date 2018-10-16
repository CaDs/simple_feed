class SessionsController < ApplicationController

  # GET /sessions/new
  def new
  end


  # POST /sessions
  # POST /sessions.json
  def create
    puts session_params
    user = User.find_by(email: session_params[:email], password: session_params[:password])
    redirect_to :new unless user

    session[:user_id] = user.id
    redirect_to posts_path
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.fetch(:session, {})
    end
end
