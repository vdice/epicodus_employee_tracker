require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions,false)

describe('employee tracker app', {:type => :feature}) do

  describe('the create division path') do
    it('allows the user to create a new division') do
      visit('/')
      fill_in('name', :with => 'Safety')
      click_button('Submit')
      expect(page).to have_content('Safety')
    end
  end

  describe('the update division path') do
    it('allows the user to update a division') do
      joy_division = Division.create({:name => 'Joy'})
      visit("/divisions/#{joy_division.id()}")
      fill_in('division', :with => 'New Order')
      click_button('Update')
      expect(page).to have_content('New Order')
    end
  end

  describe('the delete division path') do
    it('allows the user to delete the division') do
      delete_division = Division.create({:name => 'Random'})
      visit("/divisions/#{delete_division.id()}")
      click_button('Destroy')
      expect(page).to have_content('Employee Tracker')
      expect(page).to_not have_content('Random')
    end
  end

  describe('create and update employee path') do
    it('allows a user to create an employee') do
      joy_division = Division.create({:name => 'Joy'})
      visit('/')
      fill_in('employee', :with => 'Homer')
      find('#division_select').find("#option_#{joy_division.id()}").select_option
      click_button('Create')
      expect(page).to have_content('Homer, Division: Joy')
    end
  end

  describe('the division listing its employees path') do
    it('allows a user to see all of the employees for a specific division') do
      joy_division = Division.create({:name => 'Joy'})
      homer = Employee.create({:name => 'Homer', :division_id => joy_division.id()})
      visit("/divisions/#{joy_division.id()}")
      expect(page).to have_content(homer.name())
    end
  end

  describe('create a project') do
    it('names a project') do
      visit("/projects")
      fill_in('project', :with => 'Active Record Many to Many')
      click_button('Save')
      expect(page).to have_content('Active Record Many to Many')
    end
  end

  describe('delete a project') do
    it('allows a user to delete a project') do
      project = Project.create({:name => 'Active Record Many to Many'})
      visit("/projects")
      click_link(project.name())
      click_button('Delete')
      expect(page).to_not have_content(project.name())
    end
  end

  describe('update a project') do
    it('allows a user to update the name of a project') do
      project = Project.create({:name => 'Active Record Many to Many'})
      visit("/projects/#{project.id()}")
      fill_in('project', :with => 'AR Many to Many')
      click_button('Update')
      expect(page).to have_content('AR Many to Many')
    end
  end
end
