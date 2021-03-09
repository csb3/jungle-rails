require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'returns an error if password and password confirmation do not match' do
      @user = User.create({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@example.com", :password => "12345678", :password_confirmation => "123456789"  })
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'returns an error if the email is already in the database' do
      @user = User.create!({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@example.com", :password => "12345678", :password_confirmation => "12345678"  })
      @user2 = User.create({ :first_name => 'Thomas', :last_name => "Hanks", :email => "user@example.COM", :password => "12345678", :password_confirmation => "12345678"  })
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'returns an error if the password is too short' do
      @user = User.create({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@example.com", :password => "1234", :password_confirmation => "1234"  })
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
    it 'validates first name' do
      @user = User.create({ :first_name => nil, :last_name => "Hanks", :email => "user@example.com", :password => "12345678", :password_confirmation => "12345678"  })
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'validates last name' do
      @user = User.create({ :first_name => 'Tom', :last_name => nil, :email => "user@example.com", :password => "12345678", :password_confirmation => "12345678"  })
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'validates email' do
      @user = User.create({ :first_name => 'Tom', :last_name => "Hanks", :email => nil, :password => "12345678", :password_confirmation => "12345678"  })
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns an instance of the user if the email and password are correct' do
      @user_example = User.create!({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@example.com", :password => "12345678", :password_confirmation => "12345678"  })
      expect(User.authenticate_with_credentials("user@example.com", "12345678")).to be_instance_of(User)
    end
    
    it 'returns an instance of the user when there is additional whitespace in the login email' do
      @user_example = User.create!({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@example.com", :password => "12345678", :password_confirmation => "12345678"  })
      expect(User.authenticate_with_credentials(" user@example.com ", "12345678")).to be_instance_of(User)
    end

    it 'returns an instance of the user when the email does not match case' do
      @user_example = User.create!({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@exAmple.com", :password => "12345678", :password_confirmation => "12345678"  })
      expect(User.authenticate_with_credentials("USER@example.com", "12345678")).to be_instance_of(User)
    end
    it 'returns nil if login info is not valid' do
      @user_example = User.create({ :first_name => 'Tom', :last_name => "Hanks", :email => "user@example.com", :password => "12345678", :password_confirmation => "12345678"  })
      expect(User.authenticate_with_credentials("user@example.com", "12345679")).to be_nil
    end
  end
end
