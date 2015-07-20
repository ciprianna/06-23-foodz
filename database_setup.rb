# Creates the database connection

# Development
configure :development do
  require "sqlite3"
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'meals_i_can_make.db')
end

# Production
configure :production do
  require "pg"
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

# foods table
unless ActiveRecord::Base.connection.table_exists?(:foods)
  ActiveRecord::Base.connection.create_table :foods do |table|
    table.text :name
    table.integer :category_id
  end
end

# categories table
unless ActiveRecord::Base.connection.table_exists?(:categories)
  ActiveRecord::Base.connection.create_table :categories do |table|
    table.text :name
  end
end

# recipe_types table
unless ActiveRecord::Base.connection.table_exists?(:recipe_types)
  ActiveRecord::Base.connection.create_table :recipe_types do |table|
    table.text :name
  end
end

# recipes table
unless ActiveRecord::Base.connection.table_exists?(:recipes)
  ActiveRecord::Base.connection.create_table :recipes do |table|
    table.text :name
    table.integer :recipe_type_id
    table.integer :time_to_make
    table.text :information
  end
end

# foods_recipes table
unless ActiveRecord::Base.connection.table_exists?(:foods_recipes)
  ActiveRecord::Base.connection.create_table :foods_recipes do |table|
    table.integer :food_id
    table.integer :recipe_id
  end
end

# users table
unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |table|
    table.text :email
    table.text :password
  end
end

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)

# DATABASE.execute("CREATE TABLE IF NOT EXISTS foods (id INTEGER PRIMARY KEY, name TEXT NOT NULL, category_id INTEGER NOT NULL);")
# DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT NOT NULL);")
# DATABASE.execute("CREATE TABLE IF NOT EXISTS recipe_types (id INTEGER PRIMARY KEY, name TEXT NOT NULL);")
# DATABASE.execute("CREATE TABLE IF NOT EXISTS recipes (id INTEGER PRIMARY KEY, name TEXT NOT NULL, recipe_type_id INTEGER NOT NULL, time_to_make INTEGER NOT NULL, information TEXT NOT NULL);")
# DATABASE.execute("CREATE TABLE IF NOT EXISTS recipes_foods (recipe_id INTEGER NOT NULL, food_id INTEGER NOT NULL);")
# DATABASE.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, email TEXT NOT NULL UNIQUE, password TEXT NOT NULL);")
#
# # Returns the results as a Hash
# ActiveRecord::Base.connection.results_as_hash = true
