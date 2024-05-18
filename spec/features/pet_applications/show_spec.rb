require "rails_helper"

# US1
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe "the application show" do
    it "shows the application attributes" do
        pet_application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great")
        
        visit "/pet_applications/#{pet_application.id}"
        save_and_open_page

        expect(page).to have_content(pet_application.name)
        expect(page).to have_content(pet_application.street)
        expect(page).to have_content(pet_application.city)
        expect(page).to have_content(pet_application.state)
        expect(page).to have_content(pet_application.zip)
        expect(page).to have_content(pet_application.description)
        expect(page).to have_content("Address: 5 Haytown Rd., Lebanon, NJ, 08889")
    end

    it "shows names of all pets this application is for (and links to their show page)" do
        cesarsapp = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great")
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        scooby = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        PetApplicationPet.create!(pet_application: cesarsapp, pet: scooby)
        binding.pry
        visit "/pet_applications/#{cesarsapp.id}"
        expect(page).to have_content(scooby.name)
        # expect(page).to have_link("Scooby", href: "/pets/#{scooby.id}") #not sure which test is best
        click_link("#{scooby}")
        expect(current_path).to eq("/pets/#{scooby.id}")
    end

end