require "test_helper"

class StaticPublicControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_public_home_url
    assert_response :success
  end

  test "should get user_dash" do
    get static_public_user_dash_url
    assert_response :success
  end

  test "should get trems" do
    get static_public_trems_url
    assert_response :success
  end
end
