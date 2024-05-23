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

RSpec.describe "the Pet Application Show" do
	context "when I visit an applications show page" do
    it "shows the application attributes" do
			pet_application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great", status: "In Progress")
			
			visit "/pet_applications/#{pet_application.id}"
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

			visit "/pet_applications/#{application.id}" 

			expect(page).to have_link("Scooby", href: "/pets/#{pet1.id}") 
			expect(page).to have_link("Lobster", href: "/pets/#{pet2.id}") 
			click_link("#{pet1.name}")
			expect(current_path).to eq("/pets/#{pet1.id}")
	 	end
  end

	# US4
    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
	context "when the application has not been submitted" do
		it "has a (Add a Pet to this Application) section with a search field" do 
			application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great", status: "In Progress")
			shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
			pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
			pet2 = Pet.create!(name: "Lobster", age: 3, breed: "doberman", adoptable: true, shelter_id: shelter.id)
			
			visit "/pet_applications/#{application.id}" 
			expect(page).to have_content("Add a Pet to this Application")
			expect(page).to have_button("Search")

			fill_in :pet_search, with: "Scooby"
    	click_button("Search")
			
			expect(current_path).to eq("/pet_applications/#{application.id}")
			expect(page).to have_content("Scooby")
			expect(page).to_not have_content("Lobster")
		end

		# US5
		# As a visitor
		# When I visit an application's show page
		# And I search for a Pet by name
		# And I see the names Pets that match my search
		# Then next to each Pet's name I see a button to "Adopt this Pet"
		# When I click one of these buttons
		# Then I am taken back to the application show page
		# And I see the Pet I want to adopt listed on this application
		it "has a adopt this pet button next to search results" do
			application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great", status: "In Progress")
			shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
			pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
			pet2 = Pet.create!(name: "Lobster", age: 3, breed: "doberman", adoptable: true, shelter_id: shelter.id)

			visit "/pet_applications/#{application.id}"

			fill_in :pet_search, with: "Scooby"
    	click_button("Search")

			expect(page).to have_content("Adopt this Pet")

			click_button("Adopt this Pet")

			expect(current_path).to eq("/pet_applications/#{application.id}")
			expect(page).to have_content("Pets Applying For")
			expect(page).to have_content("Scooby")

			fill_in :pet_search, with: "Lobster"
    	click_button("Search")
			click_button("Adopt this Pet")

			expect(page).to have_content("Lobster")
		end
	end
		# US6
		# As a visitor
		# When I visit an application's show page
		# And I have added one or more pets to the application
		# Then I see a section to submit my application
		# And in that section I see an input to enter why I would make a good owner for these pet(s)
		# When I fill in that input
		# And I click a button to submit this application
		# Then I am taken back to the application's show page
		# And I see an indicator that the application is "Pending" 
		# And I see all the pets that I want to adopt
		# And I do not see a section to add more pets to this application
	context "I have added one or more pets to the application" do
		it "has a section to submit my applicaiton" do
			application = PetApplication.create!(name: "Cesar Milan", street: "5 Haytown Rd.", city: "Lebanon", state: "NJ", zip: "08889", description: "I'd be great", status: "In Progress")
			shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
			pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
			pet2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
			PetApplicationPet.create!(pet_application: application, pet: pet1)
			PetApplicationPet.create!(pet_application: application, pet: pet2)

			visit "/pet_applications/#{application.id}" 
			expect(page).to have_content("Submit this Application")
			fill_in :reasons, with: "fenced yard"
			click_button("Submit Application")
			expect(current_path).to eq("/pet_applications/#{application.id}")
			# save_and_open_page 
			expect(page).to have_content("Status: Pending")
		end
	end

end