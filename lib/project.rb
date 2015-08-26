class Project < ActiveRecord::Base
  has_many(:employees)
  # belongs_to(:division)
end
