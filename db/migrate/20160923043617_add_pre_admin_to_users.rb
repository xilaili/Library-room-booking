class AddPreAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pre_admin, :boolean, default: false
  end
end
