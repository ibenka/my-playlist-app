class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :url
      t.float :order
      t.references :topic, index: true
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
