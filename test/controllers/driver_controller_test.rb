require 'test_helper'

class DriverControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get driver_index_url
    assert_response :success
  end

end
