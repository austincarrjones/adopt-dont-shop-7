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

        expect(page).to have_content(pet_application.name)
        expect(page).to have_content(pet_application.street)
        expect(page).to have_content(pet_application.city)
        expect(page).to have_content(pet_application.state)
        expect(page).to have_content(pet_application.zip)
        expect(page).to have_content(pet_application.description)
    end

    xit ""
end