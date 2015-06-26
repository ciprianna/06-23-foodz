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

    return valid
  end

  # CRUD
  # ------
  # Create
  #   - initialize (Class)
  #   - add_to_database (Instance)
  #   - "extend" add method (Class)
  # Read
  #   - where_category (Class)
  #   - "extend" all method (Class)
  # Update
  #   - valid_save (Instance)
  #   - "include" save method (Instance)
  # Delete
  #   - "include" delete method (Instance)
end
