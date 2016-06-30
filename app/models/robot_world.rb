require 'yaml/store'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << { "id" => database['total'], "name" => robot[:name], "city" => robot[:city],
                              "state" => robot[:state], "birthdate" => robot[:birthdate],
                              "date_hired" => robot[:date_hired], "department" => robot[:department]
                            }
    end
  end

  # def generate(robot)
    #   @robot_world = RobotWorld.new(database)
    #   1.times do
    #     @robot_world.create({
    #       name: Faker::Name.name,
    #       id: Faker::Number.number(100),
    #       city: Faker::Address.city,
    #       state: Faker::Address.state,
    #       birthdate: '01/01/2016',
    #       date_hired: '01/01/2016',
    #       department: Faker::Company.name,
    #     })
    #   end
    #   @robot_world
    # end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot)
    database.transaction do
      target = database['robots'].find { |robot| robot["id"] == id }
      target["name"]       = robot[:name]
      target["city"]       = robot[:city]
      target["state"]      = robot[:state]
      target["birthdate"]  = robot[:birthdate]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def destroy(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id }
    end
  end
end
