class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
