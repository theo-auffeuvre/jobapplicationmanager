class Task < ApplicationRecord

  belongs_to :job

  validates :title, presence: true

end
