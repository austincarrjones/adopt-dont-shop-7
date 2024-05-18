class AddStateToPetApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :pet_applications, :state, :string
  end
end
