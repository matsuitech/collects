class AddHashTagToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :hash_tag, :string
  end
end
