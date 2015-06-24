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

end
