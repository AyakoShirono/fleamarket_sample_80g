class UsersController < ApplicationController

  def show
    profile = Profile.find(params[:id])
    user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    if current_user.update(user_params)
      sign_in(current_user, bypass: true)
      redirect_to user_path, notice: "更新が完了しました"
    else
      redirect_to  edit_user_registration_path(current_user), alert: "更新できませんでした"
    end
  end

  def destroy
    sign_out(current_user)
  end
 
  private
  def user_params
    params.require(:user).permit(:password, :nickname, :email)
  end
end
