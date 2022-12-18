class AddColumnAccountClosedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :account_closed, :boolean
  end
end
