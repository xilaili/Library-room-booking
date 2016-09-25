class AddUserEmailToHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :histories, :user_email, :string
  end
end
