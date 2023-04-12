class CreateDocumentAttachements < ActiveRecord::Migration[7.0]
  def change
    create_table :document_attachements do |t|
      t.references :document, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
