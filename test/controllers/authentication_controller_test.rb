require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should get new_session" do
    get authentication_new_session_url
    assert_response :success
  end

  test "should get create_session" do
    get authentication_create_session_url
    assert_response :success
  end

  test "should get new_registration" do
    get authentication_new_registration_url
    assert_response :success
  end

  test "should get create_registration" do
    get authentication_create_registration_url
    assert_response :success
  end

  test "should get destroy_session" do
    get authentication_destroy_session_url
    assert_response :success
  end
end
