class UsersController < ApplicationController

  def show
  end

  def edit
    user = User.create(user_params)
    redirect_to user_path(current_user)
  end

  # def destroy
  #   user = User.find(user_params)
  #   user.destroy
  #   redirect_to users_destroy_path
  # end
 
end
