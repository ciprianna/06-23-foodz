# Creates the database connection
DATABASE = SQLite3::Database.new("meals_i_can_make.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS foods (id INTEGER PRIMARY KEY, name TEXT NOT NULL, category_id INTEGER NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS recipe_types (id INTEGER PRIMARY KEY, name TEXT NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS recipes (id INTEGER PRIMARY KEY, name TEXT NOT NULL, recipe_type_id INTEGER NOT NULL, time_to_make INTEGER NOT NULL, information TEXT NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS recipes_foods (recipe_id INTEGER NOT NULL, food_id INTEGER NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, email TEXT NOT NULL, password TEXT NOT NULL);")

# Returns the results as a Hash
DATABASE.results_as_hash = true
