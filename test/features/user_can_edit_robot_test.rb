require_relative "../test_helper"

class UserCanEditARobotTest < FeatureTest
  def test_user_can_edit_a_robot
    visit "/"
    click_link "New Robot"
    assert_equal "/robots/new", current_path
    page.fill_in "Name", with: "Kristaps"
    click_button "Build My Bot!"
    assert_equal "/robots", current_path
    click_link "Edit"
    assert page.has_content? "Edit"
    page.fill_in "name", with: "Carmelo"
    click_button "Edit!"
    assert_equal "/robots", current_path
    click_link "Carmelo"
    assert page.has_content? "Carmelo"
  end
end
