require "minitest/autorun"
require_relative "../models/recipe.rb"

class RecipeTest < Minitest::Test

  # Test to ensure an empty Hash is created when a new Object is initialized
  # Should return nil values for id, name, recipe_type, time, and information
  def test_initialize_hash_created
    new_recipe = Recipe.new

    assert_equal(nil, new_recipe.id)
    assert_equal(nil, new_recipe.name)
    assert_equal(nil, new_recipe.recipe_type)
    assert_equal(nil, new_recipe.time_to_make)
    assert_equal(nil, new_recipe.information)
  end

  # Test to ensure that valid method returns true if the object is valid and
  #   false, if not
  def test_valid
    new_recipe = Recipe.new

    assert_equal(false, new_recipe.valid?)

    new_recipe.name = "tacos"
    assert_equal(false, new_recipe.valid?)

    new_recipe.recipe_type_id = 1
    assert_equal(false, new_recipe.valid?)

    new_recipe.time_to_make = 20
    assert_equal(false, new_recipe.valid?)

    new_recipe.information = "Step 1"
    assert_equal(true, new_recipe.valid?)

    new_recipe.name = ""
    assert_equal(false, new_recipe.valid?)

    new_recipe.name = "tacos"
    new_recipe.recipe_type_id = ""
    assert_equal(false, new_recipe.valid?)

    new_recipe.recipe_type_id = 2
    new_recipe.time_to_make = ""
    assert_equal(false, new_recipe.valid?)

    new_recipe.time_to_make = 45
    new_recipe.information = ""
    assert_equal(false, new_recipe.valid?)
  end

end
