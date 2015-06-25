require "minitest/autorun"
require_relative "../models/category.rb"

class CategoryTest < Minitest::Test

  # Test to ensure an empty Hash is created when a new Object is initialized
  # Should return nil values for id and name
  def test_initialize_hash_created
    dairy = Category.new

    assert_equal(nil, dairy.id)
    assert_equal(nil, dairy.name)
  end

  # Test to ensure that valid method returns true if the object is valid and
  #   false, if not
  def test_valid
    dairy = Category.new

    assert_equal(false, dairy.valid?)

    dairy.name = ""
    assert_equal(false, dairy.valid?)

    dairy.name = "dairy"
    assert_equal(true, dairy.valid?)
  end

end
