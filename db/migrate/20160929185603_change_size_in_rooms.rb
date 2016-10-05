class ChangeSizeInRooms < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :size, :string
    add_column :rooms, :building, :string
  end
end
