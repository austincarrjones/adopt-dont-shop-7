class PetApplicationsController < ApplicationController
  def new
  end

  def create
    @application = PetApplication.create(name: params[:name], street: params[:street], city: params[:city], state: params[:state], zip: params[:zip], description: params[:description])
    if @application.save
      flash[:notice] = "Application was successfully created."
      redirect_to "/pet_applications/#{@application.id}"
    else
      flash[:alert] = "You must fill in all fields"
      redirect_to "/pet_applications/new"
    end
  end

  def show
    # binding.pry
    @pet_application = PetApplication.find(params[:id])
    # binding.pry
  end
end