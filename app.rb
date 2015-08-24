require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
require('pg')
also_reload("lib/**/*.rb")
require('./lib/division')
require('./lib/employee')

get('/') do
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:index)
end

post('/') do
  @divisions = Division.all()
  @employees = Employee.all()

  if (params.has_key?('name'))
    name = params.fetch('name')
    Division.create({:name => name})
  end

  if (params.has_key?('employee'))
    employee_name = params.fetch('employee')
    division_id = params.fetch('division_select').to_i
    employee = Employee.create({:name => employee_name, :division_id => division_id})
  end

  erb(:index)
end


get('/divisions/:id') do
  @division = Division.find(params.fetch("id").to_i)
  erb(:division)
end

patch('/divisions/:id') do
  name = params.fetch('division')

  @division = Division.find(params.fetch('id').to_i)
  @division.update({:name => name})
  erb(:division)
end

delete('/divisions/:id') do
  Division.find(params.fetch('id').to_i).destroy()

  @divisions = Division.all()
  erb(:index)
end
