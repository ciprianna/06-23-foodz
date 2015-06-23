require "pry"
require "sinatra"
require "sinatra-reloader"

# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

# Models
require_relative "models/food.rb"

# Controllers
require_relative "controllers/food.rb"
