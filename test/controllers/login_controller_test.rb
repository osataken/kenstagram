require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  	setup do
    	@user = users(:normal_user)
  	end

  	test "should return user info with api key" do
      	post :authenticate, { 
        	username: @user.username,
        	password: 'encryptedpassword'
      	}

      	assert_response 200
      	response_json = JSON.parse(@response.body)
      	assert_equal(@user.username, response_json['username'])
      	assert_equal(@user.api_key, response_json['api_key'])
      	assert_equal(@user.email, response_json['email'])

     	assert_not_nil(response_json['created_at'])
    	assert_not_nil(response_json['updated_at'])
  	end

  	test "should not logon when wrong password provided" do
  		post :authenticate, { 
        	username: @user.username,
        	password: 'wrongpassword'
      	}

      	assert_response 403
        response_json = JSON.parse(@response.body)
        assert_equal('Invalid credentials, please input correct username and password', response_json['error'])
     end

    test "should not logon when wrong username provided" do
      post :authenticate, { 
          username: 'fakeusername',
          password: 'encryptedpassword'
        }

        assert_response 403
        response_json = JSON.parse(@response.body)
        assert_equal('Invalid credentials, please input correct username and password', response_json['error'])
     end


  	test "should not logon when username is empty" do
      	post :authenticate, { 
        	username: '',
        	password: 'encryptedpassword'
      	}

      	assert_response 403
      	response_json = JSON.parse(@response.body)
      	assert_equal('username and password are required', response_json['error'])
  	end

  	test "should not logon when password is empty" do
      	post :authenticate, { 
        	username: 'normaluser',
        	password: ''
      	}

      	assert_response 403
      	response_json = JSON.parse(@response.body)
      	assert_equal('username and password are required', response_json['error'])
  	end
end
