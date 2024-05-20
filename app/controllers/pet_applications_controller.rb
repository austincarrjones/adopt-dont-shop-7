class PetApplicationsController < ApplicationController
  def new
  end

  def create
    @application = PetApplication.create(name: params[:name], street: params[:street], city: params[:city], state: params[:state], zip: params[:zip], description: params[:description])
    if @application.save
      redirect_to "/pet_applications/#{@application.id}"
    else
      redirect_to "/pet_applications/new", notice: "You must fill in all fields"
    end
  end

  def show
    # binding.pry
    @pet_application = PetApplication.find(params[:id])
    # binding.pry
  end
end