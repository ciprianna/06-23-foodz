require "minitest/autorun"
require_relative "../models/food.rb"

class FoodTest < Minitest::Test

  # Test to ensure an empty Hash is created when a new Object is initialized
  # Should return nil values for id, name, and category if the empty options
  #   Hash works correctly.
  def test_initialize_hash_created
    pasta = Food.new

    assert_equal(nil, pasta.id)
    assert_equal(nil, pasta.name)
    assert_equal(nil, pasta.category_id)
  end

  # Test to ensure that valid method returns true if the object is valid and
  #   false, if not
  def test_valid
    pasta = Food.new

    assert_equal(false, pasta.valid?)

    pasta.name = "pasta"
    assert_equal(false, pasta.valid?)

    pasta.category_id = 4
    assert_equal(true, pasta.valid?)

    pasta.name = ""
    assert_equal(false, pasta.valid?)

    pasta.name = "pasta"
    pasta.category_id = ""
    assert_equal(false, pasta.valid?)
  end

end
