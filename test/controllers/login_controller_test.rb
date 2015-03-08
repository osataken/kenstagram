require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  setup do
    @user = users(:normal_user)
  end

  test "should return user info with api key" do
      post :authenticate, user: { 
        username: @user.username,
        password: 'encrypedpassword'
      }
      assert_response 200
  end
end
