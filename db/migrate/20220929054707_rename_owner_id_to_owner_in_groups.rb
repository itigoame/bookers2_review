class RenameOwnerIdToOwnerInGroups < ActiveRecord::Migration[6.1]
  def change
    def up
    rename_column :groups, :owner_id, :owner
    end

    def down
      rename_column :groups, :owner, :owner_id
    end
  end
end
