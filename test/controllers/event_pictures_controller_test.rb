require 'test_helper'

class EventPicturesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get event_pictures_new_url
    assert_response :success
  end

  test "should get create" do
    get event_pictures_create_url
    assert_response :success
  end

end
