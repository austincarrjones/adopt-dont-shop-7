class CreatePetApplicationPets < ActiveRecord::Migration[7.1]
  def change
    create_table :pet_application_pets do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :pet_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
