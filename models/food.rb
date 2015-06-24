# Food Model
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Food
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :group

  # Initializes a new Food Object
  #
  # options - Empty Hash
  #   - id (optional) - Integer, primary key
  #   - name (optional) - String for the food name
  #   - group (optional) - String for the food group
  #
  # Returns a Food Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
    @group = options["group"]
  end

  # Returns all rows from the foods table in the passed group
  #
  # group - String for the food group
  #
  # Returns an Array of Food Objects
  def self.where_group(group)
    results = DATABASE.execute("SELECT * FROM foods WHERE group = '#{group}';")

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
      Food.add({"name" => "#{self.name}", "group" => "#{self.group}"})
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

    if self.group.nil? || self.group == ""
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
  #   - where_group (Class)
  #   - "extend" all method (Class)
  # Update
  #   - valid_save (Instance)
  #   - "include" save method (Instance)
  # Delete
  #   - "include" delete method (Instance)
end
