class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :students do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :students, :name, unique: true
  end
end
