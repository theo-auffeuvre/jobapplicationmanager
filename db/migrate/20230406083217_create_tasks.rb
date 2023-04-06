class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :starts_at
      t.date :ends_at
      t.string :note
      t.boolean :task_status
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
