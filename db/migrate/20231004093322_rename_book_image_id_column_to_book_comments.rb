class RenameBookImageIdColumnToBookComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :book_comments, :book_image_id, :book_id
  end
end
