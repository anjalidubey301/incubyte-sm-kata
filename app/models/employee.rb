class Employee < ApplicationRecord
  validates :full_name, :job_title, :country, presence: true
end
