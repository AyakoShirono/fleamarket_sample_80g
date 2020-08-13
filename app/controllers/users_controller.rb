class UsersController < ApplicationController

  def show
  end

  def edit
    @user = User.find(user[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    sign_in(user, bypass: true)
    redirect_to user_path(user.id)
  end

  def destroy
    user = User.find(params[:id])
    sign_out(current_user)
  end
 
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
