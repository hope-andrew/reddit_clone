class RemoveSubIdFromPosts < ActiveRecord::Migration
  def change
    revert do
      add_column :posts, :sub_id, :integer
    end
  end
end
