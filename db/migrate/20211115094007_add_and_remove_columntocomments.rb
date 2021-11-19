class AddAndRemoveColumntocomments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :notes_id
    add_column :comments, :notes_id, :integer
  end
end
