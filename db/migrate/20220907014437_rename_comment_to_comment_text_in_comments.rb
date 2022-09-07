class RenameCommentToCommentTextInComments < ActiveRecord::Migration[6.1]
  def up
    rename_column :comments, :comment, :comment_text
  end

  def down
    rename_column :comments, :comment_text, :comment
  end
end
