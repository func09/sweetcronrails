class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :feed_id, :null => false, :default => 0
      t.string :link, :null => false, :default => ""
      t.string :title, :null => false, :default => ""
      t.text :body
      t.string :author
      t.string :category
      t.integer :version, :null => false, :default => 1
      t.datetime :stored_on
      t.datetime :modified_on
      t.timestamps
    end
    add_index :items, :feed_id
  end

  def self.down
    drop_table :items
  end
end
