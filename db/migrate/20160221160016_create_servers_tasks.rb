class CreateServersTasks < ActiveRecord::Migration
  def change
    create_table :servers_tasks do |t|
      t.references :server, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end