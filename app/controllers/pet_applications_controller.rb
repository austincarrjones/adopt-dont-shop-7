class PetApplicationsController < ApplicationController
  def new
  end

  def create
    @application = PetApplication.create(name: params[:name], street: params[:street], city: params[:city], state: params[:state], zip: params[:zip], description: params[:description])
    if @application.save
      @application.status_change("In Progress")
      redirect_to "/pet_applications/#{@application.id}"
    else
      redirect_to "/pet_applications/new", notice: "You must fill in all fields"
    end
  end

  def show
    @pet_application = PetApplication.find(params[:id])
    # binding.pry
    if params[:pet_search].present?
      @pets = Pet.search(params[:pet_search])
    # binding.pry
    end
  end

  def update
    pet_application = PetApplication.find(params[:id])
    if params[:reasons].present?
      pet_application.status_change("Pending")
      redirect_to "/pet_applications/#{pet_application.id}"
    end
    # binding.pry
  end
end