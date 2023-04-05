class AddStatusToJob < ActiveRecord::Migration[7.0]
  def change
    add_reference :jobs, :status, foreign_key: true
  end
end
