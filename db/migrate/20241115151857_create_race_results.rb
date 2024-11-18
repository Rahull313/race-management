class CreateRaceResults < ActiveRecord::Migration[7.2]
  def change
    create_table :race_results do |t|
      t.references :race, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.integer :place

      t.timestamps
    end
  end
end
