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

  context 'POST /users' do
    it 'creates and saves the valid user' do
      visit new_user_path

      fill_in 'Email', with: 'xajler@gmail.com'
      fill_in 'Password', with: 'x1234567'
      fill_in 'Confirm Password', with: 'x1234567'
      fill_in 'Full Name', with: 'Kornelije Sajler'
      click_button 'Sign Up'

      current_path.should == signup_path
      page.should have_content 'The User is successfully saved!'
    end

    context 'not saving invalid user' do
      it 'when passwords mismatch' do
        visit new_user_path

        fill_in 'Email', with: 'xajler@gmail.com'
        fill_in 'Password', with: 'x1234567'
        fill_in 'Confirm Password', with: 'x123'
        fill_in 'Full Name', with: 'Kornelije Sajler'
        click_button 'Sign Up'

        current_path.should == signup_path
        page.should have_content "Password doesn't match confirmation"
      end

      it 'when email is blank' do
        visit new_user_path

        fill_in 'Email', with: ''
        fill_in 'Password', with: 'x1234567'
        fill_in 'Confirm Password', with: 'x1234567'
        fill_in 'Full Name', with: 'Kornelije Sajler'
        click_button 'Sign Up'

        current_path.should == signup_path
        page.should have_content "Email can't be blank"
      end

      it 'when password is blank' do
        visit new_user_path

        fill_in 'Email', with: 'xajler@gmail.com'
        fill_in 'Password', with: ''
        fill_in 'Confirm Password', with: ''
        fill_in 'Full Name', with: 'Kornelije Sajler'
        click_button 'Sign Up'

        current_path.should == signup_path
        page.should have_content "Password digest can't be blank"
      end

      it 'when full name is blank' do
        visit new_user_path

        fill_in 'Email', with: 'xajler@gmail.com'
        fill_in 'Password', with: 'x1234567'
        fill_in 'Confirm Password', with: 'x1234567'
        fill_in 'Full Name', with: ''
        click_button 'Sign Up'

        current_path.should == signup_path
        page.should have_content "Full name can't be blank"
      end

      it 'when email is not unique' do
        create :user
        visit new_user_path

        fill_in 'Email', with: 'xajler@gmail.com'
        fill_in 'Password', with: 'x1234567'
        fill_in 'Confirm Password', with: 'x1234567'
        fill_in 'Full Name', with: 'Kornelije Sajler'
        click_button 'Sign Up'

        current_path.should == signup_path
        page.should have_content 'Email has already been taken'
      end

      it 'when password is less than 8 characters' do
        visit new_user_path

        fill_in 'Email', with: 'xajler@gmail.com'
        fill_in 'Password', with: '123'
        fill_in 'Confirm Password', with: '123'
        fill_in 'Full Name', with: 'Kornelije Sajler'
        click_button 'Sign Up'

        current_path.should == signup_path
        page.should have_content "Password is too short (minimum is 8 characters)"
      end
    end
  end

  context 'PUT users/:id' do
    it 'valid user update' do
      user = create :user
      visit edit_user_path user

      find_field('Email').value.should == 'xajler@gmail.com'
      find_field('Full Name').value.should == 'Kornelije Sajler'

      fill_in 'Email', with: 'xajler@gmail.com'
      fill_in 'Password', with: 'aoeuidht'
      fill_in 'Confirm Password', with: 'aoeuidht'
      fill_in 'Full Name', with: 'Kornelije Sajler - xajler'
      click_button 'Update User'

      current_path.should == edit_user_path(user)
      page.should have_content 'The User is successfully updated!'
    end

    it 'invalid when passwords mismatch' do
      user = create :user
      visit edit_user_path user

      fill_in 'Email', with: 'xajler@gmail.com'
      fill_in 'Password', with: 'aoeuidht'
      fill_in 'Confirm Password', with: 'aoeu'
      fill_in 'Full Name', with: 'Kornelije Sajler'
      click_button 'Update User'

      current_path.should == edit_user_path(user)
      page.should have_content "Password doesn't match confirmation"
    end

    it 'keeps the User Email intact while other fields do change' do
      user = create :user
      visit edit_user_path user

      find_field('Email').value.should == 'xajler@gmail.com'
      find_field('Full Name').value.should == 'Kornelije Sajler'

      fill_in 'Email', with: 'xxx@example.com'
      fill_in 'Password', with: 'aoeuidht'
      fill_in 'Confirm Password', with: 'aoeuidht'
      fill_in 'Full Name', with: 'Kornelije Sajler - xajler'
      click_button 'Update User'

      current_path.should == edit_user_path(user)
      find_field('Email').value.should == 'xajler@gmail.com'
      find_field('Full Name').value.should == 'Kornelije Sajler - xajler'
    end
  end
end
