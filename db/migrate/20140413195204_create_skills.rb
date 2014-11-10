class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name, limit: 200, null: false
      t.string :handle, limit: 60, null: false, unique: true, index: true
      t.text :sample_solution

      t.timestamps
    end
  end
end
