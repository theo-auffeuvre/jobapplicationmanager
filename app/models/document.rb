class Document < ApplicationRecord
  has_one_attached :main_document
  has_many :document_attachements, dependent: :destroy
  belongs_to :user
  has_many :document_jobs, dependent: :destroy
  has_many :jobs, through: :document_jobs
end
