class UsersController < ApplicationController

  def show
    profile = Profile.find(params[:id])
    user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    current_user.update(user_params)
    sign_in(current_user, bypass: true)
    redirect_to user_path
  end

  def destroy
    sign_out(current_user)
  end
 
  private
  def user_params
    params.require(:user).permit(:password, :nickname, :email)
  end
end
