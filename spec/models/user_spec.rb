require 'rails_helper'

RSpec.describe User, type: :model do


  describe 'Validations' do
    
    it 'is valid with valid attributes' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_valid
    end

    it 'should not save if email was not entered' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: '',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_invalid
    end

    it 'should not save if first name was not entered' do
      user = User.new(
        first_name: '',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_invalid
    end

    it 'should not save if last name was not entered' do
      user = User.new(
        first_name: 'John',
        last_name: '',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_invalid
    end

    it 'should not save if password and password_confirmation were not provided' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: '',
        password_confirmation: ''
      )
      expect(user).to be_invalid
    end

    it 'should not save if password length is less than 8 characters' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'pas',
        password_confirmation: 'pas'
      )
      expect(user).to be_invalid
    end

    it 'should not save if password and password_confirmation do not match' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'password124',
        password_confirmation: 'password123'
      )
      expect(user).to be_invalid
    end

    it 'should save if password and password_confirmation matches' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_valid
    end

    it 'emails must be unique' do
      # if someone already signed up with cody@mail.com it should not create a new accoun with the same email
      user1 = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      user1.save

      user2 = User.new(
        first_name: 'Jamie',
        last_name: 'Lanister',
        email: 'john@example.com',
        password: 'password1234556',
        password_confirmation: 'password1234556'
      )
      expect(user2).to be_invalid

    end

    it 'emails must be unique and not case sensitive' do
      # if someone already signed up with cody@mail.com it should not create a new accoun with the same email
      user1 = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'JOHN@EXAMPLE.COM',
        password: 'password123',
        password_confirmation: 'password123'
      )
      user1.save

      user2 = User.new(
        first_name: 'Jamie',
        last_name: 'Lanister',
        email: 'john@example.com',
        password: 'password1234556',
        password_confirmation: 'password1234556'
      )
      expect(user2).to be_invalid

    end

    
  

  end

  describe '.authenticate_with_credentials' do
    
    it 'should return a user if the credentials matches with ones in database' do
      user = User.new(
        first_name: 'Jamie',
        last_name: 'Lanister',
        email: 'john@example.com',
        password: 'password1234556',
        password_confirmation: 'password1234556'
      )

      user.save

      input_email = 'john@example.com'
      input_password = 'password1234556'
      expect(User.authenticate_with_credentials(input_email, input_password)).not_to be_nil
    end

    it 'should not return a user if the credentials provided does not match the one in database' do
      user = User.new(
        first_name: 'Jamie',
        last_name: 'Lanister',
        email: 'john@example.com',
        password: 'password1234556',
        password_confirmation: 'password1234556'
      )

      user.save

      input_email = 'john@example.com'
      input_password = 'passworerrrrrrrr'
      expect(User.authenticate_with_credentials(input_email, input_password)).to be_nil
    end

    it 'if user added a few white space before email and their email is in database, they should still be able to login' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'cody@mail.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      user.save

      input_email = '   cody@mail.com'
      input_password = 'password123'

      expect(User.authenticate_with_credentials(input_email, input_password)).not_to be_nil

    end

    it 'if user typed in some wrong cases for email, it should still log them in if credentials are correct' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'cody@mail.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      user.save

      input_email = 'CoDy@mAil.com'
      input_password = 'password123'

      expect(User.authenticate_with_credentials(input_email, input_password)).not_to be_nil

    end

    it 'if user register using all caps, they should still be able to login using all caps or lowercase' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'CODY@MAIL.COM',
        password: 'password123',
        password_confirmation: 'password123'
      )
      user.save
      
      input_email = 'CODY@MAIL.COM'
      input_password = 'password123'

      expect(User.authenticate_with_credentials(input_email, input_password)).not_to be_nil
    end
  end


  

end
