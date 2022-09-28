class AddOwnerIdToGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :owner_id, :integer, null: false
  end
end
