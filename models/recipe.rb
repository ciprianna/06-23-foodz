# Recipe Model
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Recipe
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :recipe_type_id, :time_to_make, :information

  # Creates a new Recipe Object
  #
  # options - empty Hash
  #   - id (optional) - Integer, primary key
  #   - name (optional) - String, name for the Recipe
  #   - recipe_type_id (optional) - Integer, foreign key from the recipe_types
  #                               table
  #   - time_to_make (optional) - Integer, number of minutes it takes to make
  #                                 the recipe
  #   - information (optional) - String giving steps to make the recipe
  #
  # Returns new Recipe Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
    @recipe_type_id = options["recipe_type_id"]
    @time_to_make = options["time_to_make"]
    @information = options["information"]
  end

  # Gives recipes within a certain recipe type
  #
  # recipe_type_id - Integer, should match an id (primary key) from the
  #                 recipe_types table
  #
  # Returns an Array of Recipe Objects
  def where_recipe_type(recipe_type_id)
    results = DATABASE.execute("SELECT * FROM recipes WHERE recipe_type_id = #{recipe_type_id};")

    store_results = []

    results.each do |hash|
      store_results << Recipe.new(hash)
    end

    return store_results
  end

  # Returns recipes based on amount of time it takes to make
  #
  # time - String, indicating the amount of time it takes. Should be categories
  #         of either "quick", "hour", or "long"
  #
  # Returns an Array of Objects
  def where_time(time)
    if time == "quick"
      results = DATABASE.execute("SELECT * FROM recipes WHERE time_to_make >= 30;")
    elsif time == "hour"
      results = DATABASE.execute("SELECT * FROM recipes WHERE time_to_make > 30 AND WHERE time_to_make <= 65;")
    elsif time == "long"
      results = DATABASE.execute("SELECT * FROM recipes WHERE time_to_make > 65;")
    end

    store_results = []

    results.each do |hash|
      store_results << Recipe.new(hash)
    end

    return store_results
  end

  # Stores food_id and recipe_id to the recipes_foods table
  #
  # food_ids - Array of food_id Integers; primary keys in the foods table
  #
  # Returns the Object it's being called on
  def add_to_bridge(food_ids)
    recipe = DATABASE.execute("SELECT * FROM recipes_foods WHERE recipe_id = #{self.id};")

    if recipe.nil?
      food_ids.each do |f_id|
        food_ids_for_sql = f_id.to_i
        DATABASE.execute("INSERT INTO recipes_foods (recipe_id, food_id) VALUES (#{self.id}, #{food_ids_for_sql});")
      end
    else
      DATABASE.execute("DELETE FROM recipes_foods WHERE recipe_id = #{self.id}")
      food_ids.each do |f_id|
        food_ids_for_sql = f_id.to_i
        DATABASE.execute("INSERT INTO recipes_foods (recipe_id, food_id) VALUES (#{self.id}, #{food_ids_for_sql});")
      end
    end
    return self
  end

  # Selects all foods in a recipe
  #
  # Returns an Array of Hashes
  def foods
    results = DATABASE.execute("SELECT foods.name FROM foods JOIN recipes_foods ON foods.id = recipes_foods.food_id WHERE recipes_foods.recipe_id = #{self.id};")
  end

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      Recipe.add({"name" => "#{self.name}", "recipe_type_id" => "#{self.recipe_type_id}", "time_to_make" => "#{self.time_to_make}", "information" => "#{self.information}"})
    else
      false
    end
  end

  # Ensures that an updated Recipe Object has a valid name and type before
  #   saving
  #
  # Returns the Object if saved or false if save failed
  def save_valid
    if self.valid_edits?
      self.save
    else
      false
    end
  end

  # Utility method to determine if an Object contains valid fields or not
  #
  # Returns true/false Boolean
  def valid?
    valid = true

    if self.name.nil? || self.name == ""
      valid = false
    end

    if self.recipe_type_id.nil? || self.recipe_type_id == ""
      valid = false
    end

    if self.time_to_make.nil? || self.time_to_make == ""
      valid = false
    end

    if self.information.nil? || self.information == ""
      valid = false
    end

    names = DATABASE.execute("SELECT name FROM recipes;")

    names.each do |names|
      if names["name"] == @name
        valid = false
      end
    end

    return valid
  end

  # Utility method to determine if an Object contains valid fields or not
  #   used only for edits so that it does not check for an existing name.
  #
  # Returns true/false Boolean
  def valid_edits?
    valid = true

    if self.name.nil? || self.name == ""
      valid = false
    end

    if self.recipe_type_id.nil? || self.recipe_type_id == ""
      valid = false
    end

    if self.time_to_make.nil? || self.time_to_make == ""
      valid = false
    end

    if self.information.nil? || self.information == ""
      valid = false
    end

    return valid
  end

end
