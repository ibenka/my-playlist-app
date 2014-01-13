class AddSoundcloudToUsers < ActiveRecord::Migration
  def change
    add_column :users, :soundcloud_access_token, :string
    add_column :users, :soundcloud_refresh_token, :string
    add_column :users, :soundcloud_expires_at, :datetime
  end
end
