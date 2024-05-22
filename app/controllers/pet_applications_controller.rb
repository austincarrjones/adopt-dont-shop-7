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
    @pet_application = PetApplication.find(params[:id])
    if params[:pet_search].present?
      @pets = Pet.search(params[:search])
      # binding.pry
    end
  end
end