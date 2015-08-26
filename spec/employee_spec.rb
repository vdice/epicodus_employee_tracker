require("spec_helper")

  describe(Employee) do
    describe("#division") do
      it('tell the division that the employee belongs to') do
        test_division = Division.create({:name => 'safety'})
        test_employee = Employee.create({:name => 'Karl', :division_id => test_division.id()})
        expect(test_employee.division()).to(eq(test_division))
      end
    end

    describe("#projects") do
      it('shows which projects an employee is assigned and vice versa') do
      test_project = Project.create({:name => 'epicodus employee tracker'})
      test_division = Division.create({:name => 'ruby class'})
      test_employee = Employee.create({:name => 'Vaughn', :division_id => test_division.id(), :project_ids => [test_project.id()]})
      # test_employee.projects.push(test_project)
      expect(test_employee.project_ids()).to(eq([test_project.id()]))
      # test_project.employees.push(test_employee)
      expect(test_project.employees()).to(eq([test_employee]))
      expect(test_employee.division()).to(eq(test_division))
    end
  end

  describe("#update") do
    it('can remove an employee from a project') do
      test_project = Project.create({:name => 'epicodus employee tracker'})
      test_division = Division.create({:name => 'ruby class'})
      test_employee = Employee.create({:name => 'Vaughn', :division_id => test_division.id()})

      test_employee.update({:project_ids => []})
      expect(test_employee.project_ids()).to(eq([]))
      expect(test_project.employees()).to(eq([]))

      test_employee.update({:project_ids => [test_project.id()]})
      test_project = Project.find(test_project.id())
      expect(test_employee.project_ids()).to(eq([test_project.id()]))
      expect(test_project.employees()).to(eq([test_employee]))
    end
  end
end
