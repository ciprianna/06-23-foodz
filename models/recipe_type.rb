# Categories Class
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class RecipeType
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name

  # Creates a new RecipeType Object
  #
  # options - empty Hash
  #   - id - Integer, primary key
  #   - name - String for the name of the recipe type
  #
  # Returns new RecipeType Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
  end

  # Adds a RecipeType Object to the database
  #
  # Returns the Object if it was added to the database, or false if missing info
  def add_to_database
    if valid?
      RecipeType.add({"name" => "#{self.name}"})
    else
      false
    end
  end

  # Returns all Recipe Objects in a RecipeType
  #
  # recipe_type_id - Integer indicating the id of the category; foreign key in the
  #               foods table
  #
  # Returns an Array of Recipe Objects
  def recipes
    results = DATABASE.execute("SELECT * FROM recipes WHERE recipe_type_id = '#{@id}';")

    store_results = []

    results.each do |hash|
      store_results << Recipe.new(hash)
    end

    return store_results
  end

  # Only deletes a RecipeType Object if no Recipe Objects are assigned to it
  #
  # Returns true/false Boolean
  def delete_category
    if self.recipes.empty?
      self.delete
    else
      false
    end
  end

  # Utility method to determine if an Object contains a valid field or not
  #
  # Returns true/false Boolean
  def valid?
    valid = true

    if self.name.nil? || self.name == ""
      valid = false
    end

    return valid
  end

end
