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

end
