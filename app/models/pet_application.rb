class PetApplication < ApplicationRecord
  validates :name, presence: true
  has_many :pet_application_pets
end