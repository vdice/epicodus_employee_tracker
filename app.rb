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
  @employees = Employee.all()
  erb(:project)
end

delete('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  @project.delete()
  @projects = Project.all()
  redirect('/projects')
end

delete('/projects/:id/boot') do
  @employee = Employee.find(params.fetch('employee_id').to_i())
  @project = Project.find(params.fetch('id').to_i())
  @project.employees.destroy(@employee)
  redirect("/projects/#{@project.id()}")
end

patch('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  @project.update({:name => params.fetch('project')})
  @employees = Employee.all()
  erb(:project)
end

post('/projects/:id/assign') do
  project_id = params.fetch('id').to_i()
  employee = Employee.find(params.fetch('employee_select').to_i())
  current_project_ids = employee.project_ids
  employee.update({:project_ids => current_project_ids.push(project_id)})
  @project = Project.find(project_id)
  @employees = Employee.all()
  redirect("/projects/#{project_id}")
end

get('/employees/:id') do
  @employee = Employee.find(params.fetch('id').to_i())
  @projects = Project.all()
  erb(:employee)
end

patch('/employees/:id') do
  @employee = Employee.find(params.fetch('id').to_i())
  @employee.update({:name => params.fetch('employee')})
  @projects = Project.all()
  erb(:employee)
end

delete('/employees/:id/boot') do
  @project = Project.find(params.fetch('project_id').to_i())
  @employee = Employee.find(params.fetch('id').to_i())
  @employee.projects.destroy(@project)
  redirect("/employees/#{@employee.id()}")
end

post('/employees/:id/assign') do
  employee_id = params.fetch('id').to_i()
  project = Project.find(params.fetch('project_select').to_i())
  current_employee_ids = project.employee_ids
  project.update({:employee_ids => current_employee_ids.push(employee_id)})
  @employee = Employee.find(employee_id)
  @projects = Project.all()
  redirect("/employees/#{employee_id}")
end
