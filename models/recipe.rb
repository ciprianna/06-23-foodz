# Recipe Model
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Recipe
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :recipe_type

  # Creates a new Recipe Object
  #
  # options - empty Hash
  #   - id (optional) - Integer, primary key
  #   - name (optional) - String, name for the Recipe
  #   - recipe_type (optional) - Integer, foreign key from the recipe_types
  #                               table
  #
  # Returns new Recipe Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
    @recipe_type = options["recipe_type"]
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

end
