class PetApplication < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true

  has_many :pet_application_pets
  has_many :pets, through: :pet_application_pets

  def status_change(status)
    binding.pry
    self.status = status
  end
end