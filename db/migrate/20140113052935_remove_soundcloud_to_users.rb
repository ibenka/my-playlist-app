class RemoveSoundcloudToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :soundcloud_access_token, :string
    remove_column :users, :soundcloud_refresh_token, :string
    remove_column :users, :soundcloud_expires_at, :datetime
  end
end
