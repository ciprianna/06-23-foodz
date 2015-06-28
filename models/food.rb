# Food Model
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Food
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :category_id

  # Initializes a new Food Object
  #
  # options - Empty Hash
  #   - id (optional) - Integer, primary key
  #   - name (optional) - String for the food name
  #   - category_id (optional) - String for the food group/category
  #
  # Returns a Food Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
    @category_id = options["category_id"]
  end

  # Returns all rows from the foods table in the passed category
  #
  # category_id - String for the food group/category
  #
  # Returns an Array of Food Objects
  def self.where_category(category_id)
    results = DATABASE.execute("SELECT * FROM foods WHERE category_id = '#{category_id}';")

    store_results = []

    results.each do |hash|
      store_results << Food.new(hash)
    end

    return store_results
  end

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      Food.add({"name" => "#{self.name}", "category_id" => "#{self.category_id}"})
    else
      false
    end
  end

  # Gets food names
  #
  # list - Array of food_ids (Integer) from recipes_foods
  #
  # Returns an Array of food names (Strings)
  def self.get_names(list)
    food_list = []
    list.each do |food|
      food = Food.find(food)
      food_list << food.name
    end
    return food_list
  end

  # Shows all recipes that match the selected foods
  #
  # food_ids - Array of id's for Food Objects, Integers
  #
  # Returns a Hash - keys are recipe_ids (Integers) and values are percentages
  #   of ingredients that the user has available to use
  def self.recipes(food_ids)
    store_recipes = Food.match_foods(food_ids)
    counts = Food.get_counts(store_recipes)
    recipe_ingredients = Recipe.ingredients(counts)
    in_order = Recipe.percentage_of_ingredients(recipe_ingredients, counts)
    return in_order
  end

  # Matches selected foods to recipes in the recipes_foods table
  #
  # food_ids - Array of id's (Integers) for Food Objects
  #
  # Returns an Array of recipe_ids from the bridge table
  def self.match_foods(food_ids)
    for_sql = food_ids.join(", ")
    results = DATABASE.execute("SELECT * FROM recipes_foods WHERE food_id IN (#{for_sql});")

    store_recipes = []
    results.each do |hash|
      store_recipes << hash["recipe_id"]
    end

    return store_recipes
  end

  # Counts the number of user ingredients that the recipe uses
  #
  # store_recipes - Array of recipe_ids (Integers) from recipes_foods
  #
  # Returns a Hash with recipe_id's (Integer) for the keys and the values are
  #   Integers indicating the number of user ingredients the recipe uses
  def self.get_counts(store_recipes)
    counts = Hash.new 0
    store_recipes.each do |id|
      counts[id] += 1
    end
    return counts
  end

  # Selects all foods in a recipe (called on a Recipe Object!)
  #
  # Returns an Array of Hashes
  def foods
    results = DATABASE.execute("SELECT foods.name FROM foods JOIN recipes_foods ON foods.id = recipes_foods.food_id WHERE recipes_foods.recipe_id = #{self.id};")
  end

  # Ensures that an updated Food Object has a valid name and food group before
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

    if self.category_id.nil? || self.category_id == ""
      valid = false
    end

    names = DATABASE.execute("SELECT name FROM foods;")

    names.each do |names|
      if names["name"] == @name
        valid = false
      end
    end

    return valid
  end

end
