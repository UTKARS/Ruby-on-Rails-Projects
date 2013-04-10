class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.text :name
      t.text :room
      t.integer :number
      t.integer :day
      t.references :schedule
      t.timestamps
    end
	add_index :lessons,:schedule_id
  end
end
