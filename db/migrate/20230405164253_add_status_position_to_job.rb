class AddStatusPositionToJob < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :status_position, :integer
  end
end
