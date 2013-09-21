class ChangeUsernameStringToString < ActiveRecord::Migration
  def change
    rename_column :users, :username_string, :username
  end
end
