# User Model
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class User
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :email, :password

  # Initializes a new User Object
  #
  # options - Empty Hash
  #   - id (optional) - Integer, primary key
  #   - email (optional) - String for the user's email
  #   - password (optional) - String for the user's password
  #
  # Returns a User Object
  def initialize(options = {})
    @id = options["id"]
    @email = options["email"]
    @password = options["password"]
  end

  # Checks if a given email exists or not
  #
  # email - String for the user's email
  #
  # Returns the User Object, if it exists, else false
  def self.find_email(email)
    results = DATABASE.execute("SELECT * FROM users WHERE email = #{email};").first

    if !results.nil
      user = User.find(results['id'])
      return user
    else
      false
    end
  end

  # Adds a new Object to the database if it has valid fields
  #
  # Returns the Object if it was added to the database or false if it failed
  def add_to_database
    if self.valid?
      encrypted_pw = BCrypt::Password.create(self.password)
      User.add({"email" => "#{self.email}", "password" => "#{encrypted_pw}"})
    else
      false
    end
  end

  # Utility method to determine if an Object contains valid fields or not
  #
  # Returns true/false Boolean
  def valid?
    valid = true

    if self.email.nil? || self.email == ""
      valid = false
    end

    if self.password.nil? || self.password == ""
      valid = false
    end

    emails = DATABASE.execute("SELECT email FROM users;")

    emails.each do |email|
      if email["email"] == @email
        valid = false
      end
    end

    return valid
  end

end
