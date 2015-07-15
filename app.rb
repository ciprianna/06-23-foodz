require "pry"
require "sinatra"
require "sinatra/reloader"
require "bcrypt"
set :sessions, true

# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

# Models
require_relative "models/food.rb"
require_relative "models/category.rb"
require_relative "models/recipe_type.rb"
require_relative "models/recipe.rb"

# Controllers
require_relative "controllers/main.rb"
require_relative "controllers/food.rb"
require_relative "controllers/category.rb"
require_relative "controllers/recipe_type.rb"
require_relative "controllers/recipe.rb"
