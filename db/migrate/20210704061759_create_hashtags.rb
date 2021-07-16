class CreateHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags do |t|
      t.string :hash_name

      t.timestamps
    end
    add_index :hashtags, :hash_name, unique: true
  end
end
