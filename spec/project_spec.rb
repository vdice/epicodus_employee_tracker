require('spec_helper')

describe(Project) do
  describe('#employees') do
    it('shows employees assigned to a project') do
      project = Project.create({:name => 'New Project'})
      division = Division.create({:name => "HR"})
      employee1 = Employee.create({:name => 'Karl', :division_id => division.id(), :project_id => project.id()})
      employee2 = Employee.create({:name => 'Lenny', :division_id => division.id(), :project_id => project.id()})
      expect(project.employees()).to(eq([employee1, employee2]))
    end
  end  
end
