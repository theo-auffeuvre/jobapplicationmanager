class RemoveJobToContact < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :job_id
  end
end
