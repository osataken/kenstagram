require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:normal_user)
    @another_user = users(:another_user)
    @request.env['HTTP_AUTHORIZATION'] = 'Token ' + @user.api_key
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end


  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { 
        email: "testemail@test.com", 
        password: "testpassword", 
        username: "testuser" }
    end

    assert_response 201
  end


  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { 
      email: "testupdateemail@test.com"
    }
    assert_response 204
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_response 204
  end

  test "should not update user by non-owner" do
    put :update, id: @another_user, user: { 
      email: "testupdateemail@test.com"
    }
    
    assert_response 401
  end
end
