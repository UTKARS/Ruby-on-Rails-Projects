class CreateLessonScheds < ActiveRecord::Migration
  def change
    create_table :lesson_scheds do |t|

      t.timestamps
    end
  end
end
