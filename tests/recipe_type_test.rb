require "minitest/autorun"
require_relative "../models/recipe_type.rb"

class RecipeTypeTest < Minitest::Test

  # Test to ensure an empty Hash is created when a new Object is initialized
  # Should return nil values for id and name
  def test_initialize_hash_created
    italian = RecipeType.new

    assert_equal(nil, italian.id)
    assert_equal(nil, italian.name)
  end

  # Test to ensure that valid method returns true if the object is valid and
  #   false, if not
  def test_valid
    italian = RecipeType.new

    assert_equal(false, italian.valid?)

    italian.name = ""
    assert_equal(false, italian.valid?)

    italian.name = "Italian"
    assert_equal(true, italian.valid?)
  end

end
