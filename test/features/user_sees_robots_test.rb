require_relative "../test_helper"

class UserSeesRobotsTest < FeatureTest

  def test_users_sees_robots
    robot1_data = {:name => "Kristaps", :city => "Liepaja", :state => "Latvia", :birthdate => "1995", :date_hired => "2015", :department => "Power Forward"}
    robot1 = robot_world.create(robot1_data)
    robot2_data = {:name => "Carmelo", :city => "Brooklyn", :state => "New York", :birthdate => "1985", :date_hired => "2010", :department => "Small Forward"}
    robot2 = robot_world.create(robot2_data)

    visit '/robots'

      assert page.has_content?("Kristaps")
      assert page.has_content?("Carmelo")
  end

end
