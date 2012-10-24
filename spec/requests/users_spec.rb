require 'spec_helper'

describe 'Users' do
  context 'GET /users/new' do
    it 'displays the create new user page' do
      visit new_user_path

      page.should have_content 'Email'
      page.should have_content 'Full Name'
      page.should have_content 'Password'
      page.should have_content 'Confirm Password'
      page.has_field? 'email'
      page.has_field? 'full_name'
      page.has_field? 'password'
      page.has_field? 'password_confirmation'
      page.has_button? 'Sign Up'
    end
  end

  context 'GET /signup' do
    it 'displays the sign up page' do
      visit signup_path

      page.should have_content 'Email'
      page.should have_content 'Full Name'
      page.should have_content 'Password'
      page.should have_content 'Confirm Password'
      page.has_field? 'email'
      page.has_field? 'full_name'
      page.has_field? 'password'
      page.has_field? 'password_confirmation'
      page.has_button? 'Sign Up'
    end
  end
end
