class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(current_user.profile.id)
  end

  def update
    profile = Profile.find(params[:id])
    profile.update(profile_params)
    redirect_to user_path
  end
  
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :zip_code, :prefecture, :city, :address, :building)
  end
end