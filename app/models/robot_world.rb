class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.execute("INSERT INTO robots (
                      name,
                      city,
                      state,
                      birthdate,
                      date_hired,
                      department
                      )
                      VALUES (?, ?, ?, ?, ?, ?);",
                      name(robot),
                      city(robot),
                      state(robot),
                      birthdate(robot),
                      date_hired(robot),
                      department(robot)
                      )
  end


  def name(robot)
    robot[:name].empty? ? Faker::Name.first_name : robot[:name]
  end

  def city(robot)
    robot[:city].empty? ? Faker::Address.city : robot[:city]
  end

  def state(robot)
    robot[:state].empty? ? Faker::Address.state : robot[:state]
  end

  def birthdate(robot)
    robot[:birthdate].empty? ? rand(1900..2000).to_s : robot[:birthdate]
  end

  def date_hired(robot)
    robot[:date_hired].empty? ? rand(2001..2016).to_s : robot[:date_hired]
  end

  def department(robot)
    robot[:department].empty? ? Faker::Commerce.department : robot[:department]
  end

  def generate(robot)
      @robot_world = RobotWorld.new(database)
      1.times do
        @robot_world.create({
          name: Faker::Name.name,
          id: Faker::Number.number(100),
          city: Faker::Address.city,
          state: Faker::Address.state,
          birthdate: '01/01/2016',
          date_hired: '01/01/2016',
          department: Faker::Company.name,
        })
      end
      @robot_world
    end

  def raw_robots
    database.execute("SELECT * FROM robots;")
    # database.transaction do
    #   database['robots'] || []
    # end
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

  def update(id,robot)
    database.execute("UPDATE robots SET
                      name = ?,
                      city = ?,
                      state = ?,
                      birthdate = ?,
                      date_hired = ?,
                      department = ?
                      WHERE id = ?;",
                      name(robot),
                      city(robot),
                      state(robot),
                      birthdate(robot),
                      date_hired(robot),
                      department(robot),
                      id
                      )
  end

  def destroy(id)
    database.execute("DELETE FROM robots WHERE id = ?;", id)
    # database.transaction do
    #   database['robots'].delete_if { |robot| robot["id"] == id }
    #end
  end

  def delete_all
    database.execute("DELETE FROM robots;")
  end

end
