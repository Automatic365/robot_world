require 'sqlite3'

environments = ["test", "development"]

environments.each do |env|
  database = SQLite3::Database.new("db/robot_world_#{env}.db")
  database.execute("CREATE TABLE robots(id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name VARCHAR(200),
                    city VARCHAR(200),
                    state VARCHAR(200),
                    birthdate INTEGER,
                    date_hired INTEGER,
                    department VARCHAR(200))
                    ;")

  puts "creating the db for #{env}"
end
