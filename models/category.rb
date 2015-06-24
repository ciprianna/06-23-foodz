# Categories Class
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Category
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name

  # Creates a new Category Object
  #
  # options - empty Hash
  #   - id - Integer, primary key
  #   - name - String for the name of the food category
  #
  # Returns new Category Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
  end

  # Adds a Category Object to the database
  #
  # Returns the Object if it was added to the database, or false if missing info
  def add_to_database
    if valid?
      Category.add({"name" => "#{self.name}"})
    else
      false
    end
  end

  # Returns all Food Objects in a Category
  #
  # category_id - Integer indicating the id of the category; foreign key in the
  #               foods table
  #
  # Returns an Array of Food Objects
  def foods
    results = DATABASE.execute("SELECT * FROM foods WHERE category_id = '#{id}';")

    store_results = []

    results.each do |hash|
      store_results << Food.new(hash)
    end

    return store_results
  end

  # Only deletes a Category Object if no Food Objects are assigned to it
  #
  # Returns true/false Boolean
  def delete_category
    if self.foods.empty?
      self.delete
    else
      false
    end
  end

  # Utility method to determine if an Object contains a valid field or not
  #
  # Returns true/false Boolean
  def valid?
    valid = true

    if self.name.nil? || self.name == ""
      valid = false
    end

    return valid
  end

end
