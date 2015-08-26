require("spec_helper")

  describe(Employee) do
    describe("#division") do
      it('tell the division that the employee belongs to') do
        test_division = Division.create({:name => 'safety'})
        test_employee = Employee.create({:name => 'Karl', :division_id => test_division.id()})
        expect(test_employee.division()).to(eq(test_division))
      end
    end

    describe("#project") do
      it('shows which project an employee is assigned to') do
      test_project = Project.create({:name => 'epicodus employee tracker'})
      test_division = Division.create({:name => 'ruby class'})
      test_employee = Employee.create({:name => 'Vaughn', :project_id => test_project.id(), :division_id => test_division.id()})
      expect(test_employee.project()).to(eq(test_project))
      expect(test_employee.division()).to(eq(test_division))
    end
  end

  describe("#update") do
    it('can remove an employee from a project') do
      test_project = Project.create({:name => 'epicodus employee tracker'})
      test_division = Division.create({:name => 'ruby class'})
      test_employee = Employee.create({:name => 'Vaughn', :project_id => test_project.id(), :division_id => test_division.id()})

      test_employee.update({:project_id => 'null'})
      expect(test_employee.project()).to(eq(nil))
      expect(test_project.employees()).to(eq([]))

      test_employee.update({:project_id => test_project.id()})
      test_project = Project.find(test_project.id())
      expect(test_employee.project()).to(eq(test_project))
      expect(test_project.employees()).to(eq([test_employee]))
    end
  end
end
