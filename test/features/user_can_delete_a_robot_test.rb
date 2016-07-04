require_relative "../test_helper"

class UserCanDeleteARobotTest < FeatureTest
  def test_user_can_delete_a_robot
    visit "/"
    click_link "New Robot"
    assert_equal "/robots/new", current_path
    page.fill_in "Name", with: "Kristaps"
    click_button "Build My Bot!"
    assert_equal "/robots", current_path
    assert page.has_content? "Kristaps"
    click_on "delete"
    assert_equal "/robots", current_path
    refute page.has_content? "Kristaps"
  end
end
