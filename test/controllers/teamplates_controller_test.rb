require 'test_helper'

class TeamplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teamplate = teamplates(:one)
  end

  test "should get index" do
    get teamplates_url
    assert_response :success
  end

  test "should get new" do
    get new_teamplate_url
    assert_response :success
  end

  test "should create teamplate" do
    assert_difference('Teamplate.count') do
      post teamplates_url, params: { teamplate: { attachable_type: @teamplate.attachable_type, file: @teamplate.file } }
    end

    assert_redirected_to teamplate_url(Teamplate.last)
  end

  test "should show teamplate" do
    get teamplate_url(@teamplate)
    assert_response :success
  end

  test "should get edit" do
    get edit_teamplate_url(@teamplate)
    assert_response :success
  end

  test "should update teamplate" do
    patch teamplate_url(@teamplate), params: { teamplate: { attachable_type: @teamplate.attachable_type, file: @teamplate.file } }
    assert_redirected_to teamplate_url(@teamplate)
  end

  test "should destroy teamplate" do
    assert_difference('Teamplate.count', -1) do
      delete teamplate_url(@teamplate)
    end

    assert_redirected_to teamplates_url
  end
end
