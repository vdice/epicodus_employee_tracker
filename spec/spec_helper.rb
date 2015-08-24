ENV['RACK_ENV'] = 'test'

require('rspec')
require('sinatra/activerecord')
require('pg')
require('division')
require('employee')

# ActiveRecord::Base.logger.level = 1
#
# RSpec.configure do |config|
#   config.after(:each) do
#     Employee.all().each() do |e|
#       e.destroy()
#     end
#
#     Division.all().each() do |d|
#       d.destroy()
#     end
#   end
# end
