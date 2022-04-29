require 'rails_helper'
feature "the signin process" do
  background do
    User.create(email:'person1@example.com',password: 'password', first_name: 'Person', last_name: '1')
  end

  scenario "Signing in with correct Credentials" do
    visit user_session_path
      fill_in 'Email', with: 'person1@example.com'
      fill_in 'Password', with: 'password'
      click_button "Log in"
      expect(current_path).to eq(root_path)
      expect(page).to have_content 'Logged in as Person'
  end

  scenario "Signing in with incorrect credentials" do
    visit user_session_path
      fill_in 'Email', with: 'person2@example.com'
      fill_in 'Password', with: 'passcode'
      click_button "Log in"
      expect(current_path).to eq(user_session_path)
      expect(page).to have_content 'Invalid Email or password'
  end

end