require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  setup do
    @user = users(:normal_user)
    @feed = feeds(:normal_feed)
    @another_user_feed = feeds(:another_user_feed)
    @request.env['HTTP_AUTHORIZATION'] = 'Token ' + @user.api_key
  end

  test "should create feed with image" do
    assert_difference('Feed.count') do
      post :create, feed: { 
        content: @feed.content, 
        user_id: @user.id,
        attachment: "data:image/png;base64,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"
      }
    end

    assert_response 201

    response_json = JSON.parse(@response.body)
    assert_equal @feed.content, response_json['content']
    assert_equal @user.id, response_json['user_id']

    assert_not_nil(response_json['created_at'])
    assert_not_nil(response_json['updated_at'])
    assert_not_nil(response_json['attachment_url'])
    assert_not_nil(response_json['attachment_content_type'])
    assert_not_nil(response_json['attachment_file_size'])
    assert_not_nil(response_json['attachment_updated_at'])
  end

  test "should not create feed when user id is missing" do
    assert_no_difference('Feed.count') do
      post :create, feed: { 
        content: '',
        user_id: @user.id
      }
    end

    assert_response 422
  end

  test "should not create feed when content is empty" do
    assert_no_difference('Feed.count') do
      post :create, feed: { 
        content: @feed.content
      }
    end

    assert_response 422
  end


  test "should show feed" do
    get :show, id: @feed
    assert_response :success

    response_json = JSON.parse(@response.body)
    assert_equal @feed.content, response_json['content']
    assert_equal @user.id, response_json['user_id']

    assert_not_nil(response_json['created_at'])
    assert_not_nil(response_json['updated_at'])
  end

  test "should update feed" do
    put :update, id: @feed, feed: { 
      content: "updated content", 
      user_id: @user.id 
    }
    
    assert_response 204
  end

  test "should destroy feed" do
    assert_difference('Feed.count', -1) do
      delete :destroy, id: @feed
    end

    assert_response 204
  end

  test "should not update feed by non-owner" do
    put :update, id: @another_user_feed, feed: { 
      content: "updated content", 
      user_id: @user.id 
    }
    
    assert_response 401
  end
end
