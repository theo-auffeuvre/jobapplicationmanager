class RemoveUserToStatus < ActiveRecord::Migration[7.0]
  def change
    remove_column :statuses, :user_id
  end
end
