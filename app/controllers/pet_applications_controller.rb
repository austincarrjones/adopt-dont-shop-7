class PetApplicationsController < ApplicationController

  def show
    # binding.pry
    @pet_application = PetApplication.find(params[:id])
    # binding.pry
  end
end