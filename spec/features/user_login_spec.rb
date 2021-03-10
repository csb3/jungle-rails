require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create!({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@example.com", :password => "12345678", :password_confirmation => "12345678"})
  end

  scenario "The user can log in" do
    visit login_path
    fill_in 'Email', with: "user@example.com"
    fill_in 'Password', with: "12345678"
    save_screenshot
    click_button 'Submit'
    expect(page).to have_content('Log out')
  end
end
