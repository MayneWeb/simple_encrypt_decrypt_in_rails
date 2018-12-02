class AddConsumerKeysToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :consumer_key, :string
    add_column :users, :consumer_secret, :string
  end
end
