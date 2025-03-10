require "test_helper"

class SupplementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get supplement_index_url
    assert_response :success
  end
end
