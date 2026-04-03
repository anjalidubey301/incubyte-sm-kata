class Employee < ApplicationRecord
  validates :full_name, :job_title, presence: true
end
