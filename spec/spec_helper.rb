ENV['RACK_ENV'] = 'test'

require('rspec')
require('capybara/rspec')
require('sinatra/activerecord')
require('pg')
require('division')
require('employee')
require('project')

RSpec.configure do |config|
  config.after(:each) do
    Employee.all().each() do |e|
      e.destroy()
    end

    Division.all().each() do |d|
      d.destroy()
    end

    Project.all().each() do |p|
      p.destroy()
    end
  end
end
