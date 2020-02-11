class AddLocationToDriver < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :location, :string
  end
end
