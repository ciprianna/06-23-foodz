# Recipe Model
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Recipe
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :recipe_type, :time_to_make, :information

  # Creates a new Recipe Object
  #
  # options - empty Hash
  #   - id (optional) - Integer, primary key
  #   - name (optional) - String, name for the Recipe
  #   - recipe_type (optional) - Integer, foreign key from the recipe_types
  #                               table
  #   - time_to_make (optional) - Integer, number of minutes it takes to make
  #                                 the recipe
  #   - information (optional) - String giving steps to make the recipe
  #
  # Returns new Recipe Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
    @recipe_type = options["recipe_type"]
    @time_to_make = options["time_to_make"]
    @information = options["information"]
  end

  # Gives recipes within a certain recipe type
  #
  # recipe_type - Integer, should match an id (primary key) from the
  #                 recipe_types table
  #
  # Returns an Array of Recipe Objects
  def where_recipe_type(recipe_type)
    results = DATABASE.execute("SELECT * FROM recipes WHERE recipe_type_id = #{recipe_type};")

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

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      Recipe.add({"name" => "#{self.name}", "recipe_type" => "#{self.recipe_type}", "time_to_make" => "#{self.time_to_make}", "information" => "#{self.information}"})
    else
      false
    end
  end

  # Ensures that an updated Recipe Object has a valid name and type before
  #   saving
  #
  # Returns the Object if saved or false if save failed
  def save_valid
    if self.valid?
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

    if self.recipe_type.nil? || self.recipe_type == ""
      valid = false
    end

    if self.time_to_make.nil? || self.time_to_make == ""
      valid = false
    end

    if self.information.nil? || self.time_to_make == ""
      valid = false
    end

    return valid
  end

end
