class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :year
      t.integer :semester
      t.references :group
      t.timestamps
    end
    add_index :schedules,:group_id
  end
end
