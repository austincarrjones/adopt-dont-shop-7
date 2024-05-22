class PetApplicationPetsController < ApplicationController
  def create
    @petapplicationpet = PetApplicationPet.create(pet_application_id: params[:app_id], pet_id: params[:pet_id])
    # binding.pry
    redirect_to "/pet_applications/#{params[:app_id]}"
  end
end