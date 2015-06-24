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
    assert_equal(nil, pasta.category)
  end

  

end
