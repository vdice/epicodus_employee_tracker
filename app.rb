require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
require('pg')
also_reload("lib/**/*.rb")
require('./lib/division')
require('./lib/employee')
require('./lib/project')

get('/') do
  @divisions = Division.all()
  @employees = Employee.all()
  @projects = Project.all()
  erb(:index)
end

post('/') do
  @divisions = Division.all()
  @employees = Employee.all()

  if (params.has_key?('name'))
    name = params.fetch('name')
    Division.create({:name => name})
  end

  if (params.has_key?('employee') && params.has_key?('division_select'))
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
  @employees = Employee.all()
  redirect('/')
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

post('/projects') do
  name = params.fetch('project')
  project = Project.create({:name => name})
  @projects = Project.all()
  erb(:projects)
end

get('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  erb(:project)
end

delete('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  @project.delete()
  @projects = Project.all()
  redirect('/projects')
end

patch('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  @project.update({:name => params.fetch('project')})
  erb(:project)
end
