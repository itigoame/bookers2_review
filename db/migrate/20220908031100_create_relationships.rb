class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower, null: false
      t.references :followed, null: false

      t.timestamps
    end
  end
end
