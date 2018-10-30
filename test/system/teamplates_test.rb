require "application_system_test_case"

class TeamplatesTest < ApplicationSystemTestCase
  setup do
    @teamplate = teamplates(:one)
  end

  test "visiting the index" do
    visit teamplates_url
    assert_selector "h1", text: "Teamplates"
  end

  test "creating a Teamplate" do
    visit teamplates_url
    click_on "New Teamplate"

    fill_in "Attachable Type", with: @teamplate.attachable_type
    fill_in "File", with: @teamplate.file
    click_on "Create Teamplate"

    assert_text "Teamplate was successfully created"
    click_on "Back"
  end

  test "updating a Teamplate" do
    visit teamplates_url
    click_on "Edit", match: :first

    fill_in "Attachable Type", with: @teamplate.attachable_type
    fill_in "File", with: @teamplate.file
    click_on "Update Teamplate"

    assert_text "Teamplate was successfully updated"
    click_on "Back"
  end

  test "destroying a Teamplate" do
    visit teamplates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Teamplate was successfully destroyed"
  end
end
