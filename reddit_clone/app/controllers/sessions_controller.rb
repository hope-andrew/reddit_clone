class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(*session_params.values)
    if @user.nil?
      flash.now[:errors] = @user.errors.full_messages
      render :new
    else
      login_user!
      redirect_to user_url(@user)
    end
  end

  def destroy
    @user = User.find_by_session_token(session[:session_token])

    if @user
      log_out!
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to new_session_url
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
