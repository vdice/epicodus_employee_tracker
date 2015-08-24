ENV['RACK_ENV'] = 'test'

require('rspec')
require('sinatra/activerecord')

ActiveRecord::Base.logger.level = 1
