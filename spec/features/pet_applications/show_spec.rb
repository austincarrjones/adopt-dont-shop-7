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
        pet_application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great", status: "In Progress")
        
        visit "/pet_applications/#{pet_application.id}"
        # save_and_open_page

        expect(page).to have_content(pet_application.name)
        expect(page).to have_content(pet_application.street)
        expect(page).to have_content(pet_application.city)
        expect(page).to have_content(pet_application.state)
        expect(page).to have_content(pet_application.zip)
        expect(page).to have_content(pet_application.description)
        expect(page).to have_content(pet_application.status)
        expect(page).to have_content("Address: 5 Haytown Rd., Lebanon, NJ, 08889")
    end

   it "shows names of all pets this application is for (and links to their show page)" do
        application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great", status: "In Progress")
        shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        pet2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
        PetApplicationPet.create!(pet_application: application, pet: pet1)
        PetApplicationPet.create!(pet_application: application, pet: pet2)
        # binding.pry
        visit "/pet_applications/#{application.id}" 
        #how do do it using this? pet_applications_path(application)
        save_and_open_page

        expect(page).to have_link("Scooby", href: "/pets/#{pet1.id}") 
        expect(page).to have_link("Lobster", href: "/pets/#{pet2.id}") 
        click_link("#{pet1.name}")
        expect(current_path).to eq("/pets/#{pet1.id}")
    end

end