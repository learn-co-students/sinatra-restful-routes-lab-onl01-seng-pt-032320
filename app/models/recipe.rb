class Recipe<ActiveRecord::Base
  validates_presence_of :name, :ingredients, :cook_time, message: "Ensure No Blank fields"
end