require 'test_helper'

class SharedControllerTest < ActionDispatch::IntegrationTest
  test "should get map_location" do
    get shared_map_location_url
    assert_response :success
  end

end
