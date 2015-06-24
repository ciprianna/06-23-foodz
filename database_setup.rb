# Creates the database connection
DATABASE = SQLite3::Database.new("meals_i_can_make.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS foods (id INTEGER PRIMARY KEY, name TEXT NOT NULL, category INTEGER NOT NULL);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT NOT NULL);")
# DATABASE.execute(";")

# Returns the results as a Hash
DATABASE.results_as_hash = true
