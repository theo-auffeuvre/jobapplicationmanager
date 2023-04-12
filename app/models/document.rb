class Document < ApplicationRecord
  has_one_attached :main_document
  has_many :document_attachements, dependent: :destroy
  belongs_to :user
end
