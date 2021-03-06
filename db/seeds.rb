require 'sqlite3'
require 'faker'

database = SQLite3::Database.new("db/robot_world_development.db")

database.execute("DELETE FROM robots;")

10.times do
  database.execute("INSERT INTO robots(
                    name,
                    city,
                    state,
                    birthdate,
                    date_hired,
                    department
                    )
                    VALUES(
                    '#{Faker::Name.first_name}',
                    '#{Faker::Address.city}',
                    '#{Faker::Address.state}',
                    '#{rand(1900..2000)}',
                    '#{rand(2001..2016)}',
                    '#{Faker::Commerce.department}'
                    );")
end

puts database.execute("SELECT * FROM robots;")
