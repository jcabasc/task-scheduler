class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :executable_path
      t.datetime :started_at
      t.datetime :ended_at
      t.text :days_of_week
      t.timestamps null: false
    end
  end
end
