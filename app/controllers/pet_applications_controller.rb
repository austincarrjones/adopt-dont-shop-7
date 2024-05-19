class PetApplicationsController < ApplicationController
  def new
  end

  def create
    @application = PetApplication.create(name: params[:name], street: params[:street], city: params[:city], 
    state: params[:state], zip: params[:zip], description: params[:description])
    redirect_to "/pet_applications/#{@application.id}"

  end
  def show
    # binding.pry
    @pet_application = PetApplication.find(params[:id])
    # binding.pry
  end
end