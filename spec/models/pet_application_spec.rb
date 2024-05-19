require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should have_many(:pet_application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) } 
  end

end