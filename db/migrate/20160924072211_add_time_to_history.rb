class AddTimeToHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :histories, :startTime, :string
    add_column :histories, :endTime, :string
  end
end
