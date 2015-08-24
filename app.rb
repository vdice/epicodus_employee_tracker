require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
require('pg')
also_reload("lib/**/*.rb")
require('./lib/division')
require('./lib/employee')

get('/') do
  @divisions = Division.all()
  erb(:index)
end

post('/') do
  name = params.fetch('name')
  Division.create({:name => name})

  @divisions = Division.all()
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
