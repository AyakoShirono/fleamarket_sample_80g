class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(current_user.profile.id)
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to user_path
    else 
      render :edit
    end
  end
  
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :zip_code, :prefecture, :city, :address, :building)
  end
end