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
erb(:index)
end

# Divisions - list all, Create, modify and delete

get('/divisions') do
  @divisions = Division.all()
  erb(:divisions)
end

post('/divisions') do
  name = params.fetch('name')
  Division.create({:name => name})
  @divisions = Division.all()
  erb(:divisions)
end

get('/divisions/:id') do
  @employees = Employee.all()
  @division = Division.find(params.fetch("id").to_i)
  erb(:division)
end

post('/divisions/:id/employee') do
  division_id = params.fetch('id').to_i()
  employee = Employee.find(params.fetch('employee_select').to_i())
  employee.update({:division_id => division_id})
  @division = Division.find(division_id)
  redirect("/divisions/#{division_id}")
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

post('/employees/:id/division') do
  employee_id = params.fetch('id').to_i()
  division = Division.find(params.fetch('division_select').to_i())
  current_employee_ids = division.employee_ids
  division.update({:employee_ids => current_employee_ids.push(employee_id)})
  @employee = Employee.find(employee_id)
  redirect("/employees/#{employee_id}")
end

# Projects - list all, Create, Modify and Delete

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

# Employees  list all, create, modify and delete

get('/employees/:id') do
  @employee = Employee.find(params.fetch('id').to_i())
  @projects = Project.all()
  @divisions = Division.all()
  erb(:employee)
end

get('/employees') do
  @employees = Employee.all()
  @projects = Project.all()
  @divisions = Division.all
  erb(:employees)
end

post('/employees') do
  if (params.has_key?('employee'))
    employee_name = params.fetch('employee')
    employee = Employee.create({:name => employee_name})
  end

  @employees = Employee.all()
  erb(:employees)
end

patch('/employees/:id') do
  @divisions = Division.all()
  @employee = Employee.find(params.fetch('id').to_i())
  @employee.update({:name => params.fetch('employee')})
  @projects = Project.all()
  erb(:employee)
end

delete('/employees/:id/boot') do

  @project = Project.find(params.fetch('project_id').to_i())
  @employee = Employee.find(params.fetch('id').to_i())
  @project.employees.destroy(@employee)
  redirect("/employees/#{@employee.id()}")
end

post('/employees/:id/project') do
  employee_id = params.fetch('id').to_i()
  project = Project.find(params.fetch('project_select').to_i())
  current_employee_ids = project.employee_ids
  project.update({:employee_ids => current_employee_ids.push(employee_id)})
  @employee = Employee.find(employee_id)
  @projects = Project.all()
  redirect("/employees/#{employee_id}")
end

delete('/employees/:id') do
  employee = Employee.find(params.fetch('id').to_i())
  employee.destroy()
  redirect('/employees')
end
