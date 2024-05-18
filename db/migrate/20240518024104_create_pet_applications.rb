class CreatePetApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :pet_applications do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :zip
      t.string :description

      t.timestamps
    end
  end
end
