class DocumentAttachement < ApplicationRecord
  belongs_to :document
  belongs_to :job, optional: true
end
