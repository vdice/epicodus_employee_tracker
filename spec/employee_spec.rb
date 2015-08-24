require("spec_helper")

  describe(Employee) do
    it('tell the division that the employee belongs to') do
      test_division = Division.create({:name => 'safety'})
      test_employee = Employee.create({:name => 'Karl', :division_id => test_division.id()})
      expect(test_employee.division()).to(eq(test_division))
    end
  end
