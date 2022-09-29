class AddGroupsToBody < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :body, :text
  end
end
