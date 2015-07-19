class Food < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :category_id, presence: true

  has_and_belongs_to_many :recipes

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
