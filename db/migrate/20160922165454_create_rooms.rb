class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :room_id
      t.integer :size
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
