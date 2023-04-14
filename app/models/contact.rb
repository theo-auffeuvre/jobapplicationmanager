class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :job, optional: true
  has_many :contact_jobs
  has_many :jobs, through: :contact_jobs
end
