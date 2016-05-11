require "yaml/store"
require_relative "robot"

class RobotWorld
attr_reader :database

  def initialize(database)
    @database = database
  end

  def raw_robots
    database.transaction do
      database["robots"] || []
    end
  end

  def all
    raw_robots.map { |robot| Robot.new(robot) }
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << {
        "id"         => database['total'],
        "name"       => robot[:name],
        "city"       => robot[:city],
        "state"      => robot[:state],
        "avatar"     => robot[:avatar],
        "birthdate"  => robot[:birthdate],
        "date_hired" => robot[:date_hired],
        "department" => robot[:department]
      }
    end
  end

  def raw_robot(name)
    raw_robots.find { |robot| robot["name"] == name.capitalize }
  end

  def find(name)
    Robot.new(raw_robot(name))
  end

  def update(name, robot)
    database.transaction do
      target_robot = database['robots'].find { |robot| robot["name"] == name }
      target_robot["city"]       = robot[:city]
      target_robot["state"]      = robot[:state]
      target_robot["department"] = robot[:department]
    end
  end
end
