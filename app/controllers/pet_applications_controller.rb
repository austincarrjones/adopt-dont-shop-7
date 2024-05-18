class PetApplicationsController < ApplicationController

  def show
    @pet_application = PetApplication.find(params[:id])
  end
end