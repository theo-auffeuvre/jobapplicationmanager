class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :location
      t.string :email
      t.integer :phone
      t.references :job, null: true, foreign_key: true

      t.timestamps
    end
  end
end
