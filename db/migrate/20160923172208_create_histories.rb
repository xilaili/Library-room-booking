class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.integer :use_id
      t.string :room_id
      t.timestamps :start_time
      t.timestamps :end_time
      t.timestamps :create_time

      t.timestamps
    end
  end
end
