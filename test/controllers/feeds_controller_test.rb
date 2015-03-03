require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  setup do
    @feed = feeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feeds)
  end

  test "should create feed" do
    assert_difference('Feed.count') do
      post :create, feed: { content: @feed.content }
    end

    assert_response 201
  end

  test "should show feed" do
    get :show, id: @feed
    assert_response :success
  end

  test "should update feed" do
    put :update, id: @feed, feed: { content: @feed.content }
    assert_response 204
  end

  test "should destroy feed" do
    assert_difference('Feed.count', -1) do
      delete :destroy, id: @feed
    end

    assert_response 204
  end
end
