class Recipe < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :recipe_type_id, presence: true
  validates :time_to_make, presence: true
  validates :information, presence: true

  has_and_belongs_to_many :foods

  # Returns recipes based on amount of time it takes to make
  #
  # time - String, indicating the amount of time it takes. Should be categories
  #         of either "quick", "hour", or "long"
  #
  # Returns an Array of Objects
  def self.where_time(time)
    if time == "quick"
      results = Recipe.where("time_to_make <= 30")
    elsif time == "hour"
      results = Recipe.where(time_to_make: 30..65)
    elsif time == "long"
      results = Recipe.where("time_to_make > 65")
    end

    return results
  end

  # Utility method - collects the number of ingredients a recipe takes
  #
  # counts - Hash with recipe_ids from recipes_foods table
  #
  # Returns a Hash with recipe_ids (Integers) as keys and total ingredients used
  #   as values (Integers)
  def self.ingredients(counts)
    recipe_ingredients = Hash.new 0
    counts.each do |key, value|
      recipe = Recipe.find(key)
      number_of_foods = recipe.foods
      recipe_ingredients[key] = number_of_foods.length
    end
    return recipe_ingredients
  end

  # Utility method - Returns the percentage of user selected ingredients out of
  #   total ingredients a recipe uses
  #
  # recipe_ingredients - Hash with recipe_ids (Integers) as keys and number of
  #                       recipe ingredients needed as the value (Integer)
  # counts - Hash with recipe_ids (Integers) as keys and number of user-selected
  #           ingredients as values (Integers)
  #
  # Returns a Hash with recipe_ids (Integers) and percentage of ingredients
  # (Floats) that the user has available as the values
  def self.percentage_of_ingredients(recipe_ingredients, counts)
    in_order = {}
    recipe_ingredients.each do |rid, ings|
      x = counts[rid].to_f / ings
      in_order[rid] = x
    end

    return in_order
  end

end
