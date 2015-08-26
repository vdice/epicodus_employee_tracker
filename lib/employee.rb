class Employee < ActiveRecord::Base
  belongs_to(:division)
  has_and_belongs_to_many(:project)
end
