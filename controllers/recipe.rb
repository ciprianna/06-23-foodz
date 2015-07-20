# # ------------------------------------------------------------------------------
# # Find if user is logged in
# # ------------------------------------------------------------------------------
# def current_user
#   if session[:user_id]
#     @current_user = User.find(session[:user_id])
#   else
#     @login_failed = true
#     return erb :"users/login"
#   end
# end

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
  @recipe_to_add = Recipe.create({"name" => params['recipe']['name'], "recipe_type_id" => params['recipe']['recipe_type_id'].to_i, "time_to_make" => params['recipe']['time_to_make'].to_i, "information" => params['recipe']['information']})

  if !@recipe_to_add.errors.empty?
    @error = true
    erb :"recipes/add_recipe"
  else
    params["food"]["food_id"].each do |food_id|
      food = Food.find(food_id)
      @recipe_to_add.foods << food
    end
    erb :"recipes/success"
  end

end

# ------------------------------------------------------------------------------
# Displays Recipe Information
# ------------------------------------------------------------------------------
get "/all_recipes/:id" do
  @recipe = Recipe.find(params['id'])
  erb :"recipes/recipe_information"
end

# ------------------------------------------------------------------------------
# Edit a recipe
# ------------------------------------------------------------------------------
# Step 1: Select a recipe to edit
get "/edit_recipe" do
  if session[:user_id]
    erb :"recipes/edit_recipe"
  else
    erb :"users/login"
  end
end

# Step 2: Display form to edit information
get "/edit_recipe/:id" do
  @recipe_to_change = Recipe.find(params["id"])
  erb :"recipes/edit_recipe_form"
end

# Step 3: Save new information
get "/save_edited_recipe" do
  @recipe_id = params["id"]
  @recipe_to_change = Recipe.find(params["recipe"]["id"])
  @recipe_to_change.name = params["recipe"]["name"]
  @recipe_to_change.time_to_make = params["recipe"]["time_to_make"].to_i
  @recipe_to_change.recipe_type_id = params["recipe"]["recipe_type_id"].to_i
  @recipe_to_change.information = params["recipe"]["information"]

  @recipe_to_change.save

  if @recipe_to_change.errors.empty?
    if !params["food"].nil?
      params["food"]["food_id"].each do |food_id|
        food = Food.find(food_id)
        @recipe_to_change.foods << food
      end
      erb :"recipes/success"
    else
      @missing_food = true
      erb :"recipes/edit_recipe_form"
    end
  else
    @recipe_to_change
    @error = true
    erb :"recipes/edit_recipe_form"
  end
end
