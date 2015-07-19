class RecipeType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :recipes

  # Only deletes a RecipeType Object if no Recipe Objects are assigned to it
  #
  # Returns true/false Boolean
  def delete_category
    if self.recipes.empty?
      self.delete
    else
      false
    end
  end

end
