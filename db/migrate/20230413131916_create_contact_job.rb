class CreateContactJob < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_jobs do |t|
      t.references :job, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
