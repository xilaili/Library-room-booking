require 'test_helper'

class HistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get histories_index_url
    assert_response :success
  end

  test "should get new" do
    get histories_new_url
    assert_response :success
  end

  test "should get create" do
    get histories_create_url
    assert_response :success
  end

  test "should get show" do
    get histories_show_url
    assert_response :success
  end

end
