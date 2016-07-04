require 'faker'

class Robot
  attr_reader :name,
              :city,
              :state,
              :birthdate,
              :date_hired,
              :department,
              :id

  def initialize(data)
    @name        = data["name"]
    @id          = data["id"]
    @avatar      = data["avatar"]
    @city        = data["city"]
    @state       = data["state"]
    @birthdate   = data['birthdate']
    @date_hired  = data['date_hired']
    @department  = data['department']
  end

  def age
    now = Time.now.utc.to_date
    now.year - created.to_i
  end

end
