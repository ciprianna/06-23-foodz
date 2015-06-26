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

# Step 2: Save new recipe
get "/save_new_recipe" do
  recipe_to_add = Recipe.new({"name" => params['recipe']['name'], "recipe_type_id" => params['recipe']['recipe_type_id'], "time_to_make" => params['recipe']['time_to_make'], "information" => params['recipe']['information']})

  if recipe_to_add.add_to_database
    erb :"recipes/success"
  else
    @error = true
    erb :"recipes/add_recipe"
  end
end

# ------------------------------------------------------------------------------
# Displays Recipe Information
# ------------------------------------------------------------------------------
get "/all_recipes/:id" do
  @recipe = Recipe.find(params['recipe']['id'])
  erb :"recipes/recipe_information"
end
