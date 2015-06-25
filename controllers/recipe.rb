# ------------------------------------------------------------------------------
# Displays all recipes
# ------------------------------------------------------------------------------
get "/all_recipes" do
  erb :"recipes/all_recipes"
end

# ------------------------------------------------------------------------------
# Displays recipes by recipe type
# ------------------------------------------------------------------------------
get "/recipes_by_type" do
  erb :"recipes/recipes_by_type"
end

# ------------------------------------------------------------------------------
# Displays recipes by time to make
# ------------------------------------------------------------------------------
# Step 1: Displays a form for the time category
get "/recipes_by_time" do
  erb :"recipes/recipes_by_time"
end

# Step 2: Save the form entries and display information back
get "/display_recipes_by_time" do
  @recipes_to_show = Recipe.where_time(params["recipes"]["time"])

  erb :"recipes/display_recipes_by_time"
end

# ------------------------------------------------------------------------------
# Adds a new recipe
# ------------------------------------------------------------------------------
# Step 1: Displays an empty form for the new recipe
get "/add_recipe" do
  erb :"recipes/add_recipe"
end

# Step 2: 
