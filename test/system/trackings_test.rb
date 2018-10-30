require "application_system_test_case"

class TrackingsTest < ApplicationSystemTestCase
  setup do
    @tracking = trackings(:one)
  end

  test "visiting the index" do
    visit trackings_url
    assert_selector "h1", text: "Trackings"
  end

  test "creating a Tracking" do
    visit trackings_url
    click_on "New Tracking"

    fill_in "Check In", with: @tracking.check_in
    fill_in "Check Out", with: @tracking.check_out
    fill_in "Date", with: @tracking.date
    fill_in "Status", with: @tracking.status
    fill_in "User Name", with: @tracking.user_name
    fill_in "Working Time", with: @tracking.working_time
    click_on "Create Tracking"

    assert_text "Tracking was successfully created"
    click_on "Back"
  end

  test "updating a Tracking" do
    visit trackings_url
    click_on "Edit", match: :first

    fill_in "Check In", with: @tracking.check_in
    fill_in "Check Out", with: @tracking.check_out
    fill_in "Date", with: @tracking.date
    fill_in "Status", with: @tracking.status
    fill_in "User Name", with: @tracking.user_name
    fill_in "Working Time", with: @tracking.working_time
    click_on "Update Tracking"

    assert_text "Tracking was successfully updated"
    click_on "Back"
  end

  test "destroying a Tracking" do
    visit trackings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tracking was successfully destroyed"
  end
end
