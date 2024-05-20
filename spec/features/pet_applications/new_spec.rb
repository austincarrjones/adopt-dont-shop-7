require "rails_helper"
#US2
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
#   - Description of why I would make a good home
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

RSpec.describe "Starting an application" do
    it "should show a link to start the application" do
        # application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great", status: "In Progress")
        shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        #pet2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
        
        visit "/pets"
        expect(page).to have_content "Start an Application"
        click_link "Start an Application"
        expect(current_path).to eq "/pet_applications/new"
    end

    it "should take me the the new application form" do
        shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
        # pet2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

        visit "/pet_applications/new"
        fill_in("name", with: "Lassie")
        fill_in("street", with: "5 Haytown Rd.")
        fill_in("city", with: "omaha")
        fill_in("state", with: "nebraska")
        fill_in("zip", with: "29345")
        fill_in("description", with: "fence")
        click_button("Submit")
        new_app_id = PetApplication.last.id
        expect(current_path).to eq("/pet_applications/#{new_app_id}")
        expect(page).to have_content("Lassie")
        expect(page).to have_content("In Progress")
    end

    #3. Starting an Application, Form not Completed
    # As a visitor
    # When I visit the new application page
    # And I fail to fill in any of the form fields
    # And I click submit
    # Then I am taken back to the new applications page
    # And I see a message that I must fill in those fields.
    it "should redirect incomplete forms" do
			shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
			pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

			visit "/pet_applications/new"
			fill_in("name", with: "Lassie")
			click_button("Submit")
			save_and_open_page
			expect(current_path).to eq("/pet_applications/new")
			expect(page).to have_content("You must fill in all fields")
    end
        

end