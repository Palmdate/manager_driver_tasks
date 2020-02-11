class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :pickup_loc
      t.string :deliver_loc
      t.string :status
      t.references :driver, null: true, foreign_key: true

      t.timestamps
    end
  end
end
