require 'rubygems'
require 'bundler/setup'

require "pry"
require "active_record"
require "sinatra"
require "sinatra/reloader"
require "bcrypt"
set :sessions, true

# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"

# Models
require_relative "models/food.rb"
require_relative "models/category.rb"
require_relative "models/recipe_type.rb"
require_relative "models/recipe.rb"
require_relative "models/user.rb"

# Controllers
require_relative "controllers/main.rb"
require_relative "controllers/food.rb"
require_relative "controllers/category.rb"
require_relative "controllers/recipe_type.rb"
require_relative "controllers/recipe.rb"
require_relative "controllers/users.rb"
