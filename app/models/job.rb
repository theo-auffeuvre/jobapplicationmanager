class Job < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :status
  has_many :tasks, dependent: :destroy
  has_many :contact_jobs, dependent: :destroy
  has_many :contacts, through: :contact_jobs

  validates :title, presence: true
  validates :user_id, presence: true
end
