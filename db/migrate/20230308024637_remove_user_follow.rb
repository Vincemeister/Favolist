class RemoveUserFollow < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_follows
  end
end
