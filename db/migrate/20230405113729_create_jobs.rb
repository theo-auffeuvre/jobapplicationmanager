class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.string :url
      t.integer :salary
      t.string :location
      t.timestamps
    end
    add_reference :jobs, :user, foreign_key: true
  end
end
