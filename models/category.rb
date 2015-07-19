class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :foods

  # Only deletes a Category Object if no Food Objects are assigned to it
  #
  # Returns true/false Boolean
  def delete_category
    if self.foods.empty?
      self.destroy
    else
      false
    end
  end

end
