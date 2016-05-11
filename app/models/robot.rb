class Robot
  attr_reader :id,
              :name,
              :city,
              :state,
              :avatar,
              :birthdate,
              :date_hired,
              :department

  def initialize(data)
    @id         = data["id"]
    @name       = data["name"].capitalize
    @city       = data["city"]
    @state      = data["state"]
    @avatar     = "<img src=\"https://robohash.org/#{name}.png\">"
    @birthdate  = data["birthdate"]
    @date_hired = data["date_hired"]
    @department = data["department"]
  end
end
