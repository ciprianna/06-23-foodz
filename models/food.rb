class Food < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :category_id, presence: true

  has_and_belongs_to_many :recipes

  # # Gets food names
  # #
  # # list - Array of food_ids (Integer) from recipes_foods
  # #
  # # Returns an Array of food names (Strings)
  # def self.get_names(list)
  #   food_list = []
  #   list.each do |food|
  #     food = Food.find(food)
  #     food_list << food.name
  #   end
  #   return food_list
  # end

  # # Matches selected foods to recipes in the recipes_foods table
  # #
  # # food_ids - Array of id's (Integers) for Food Objects
  # #
  # # Returns an Array of recipe_ids from the bridge table
  # def self.match_foods(food_ids)
  #   for_sql = food_ids.join(", ")
  #   results = DATABASE.execute("SELECT * FROM recipes_foods WHERE food_id IN (#{for_sql});")
  #
  #   store_recipes = []
  #   results.each do |hash|
  #     store_recipes << hash["recipe_id"]
  #   end
  #
  #   return store_recipes
  # end

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

end
