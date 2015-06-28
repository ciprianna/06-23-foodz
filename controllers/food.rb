# ------------------------------------------------------------------------------
# View all foods in the foods table
# ------------------------------------------------------------------------------
get "/view_all_food" do
  erb :"food/view_all_food"
end

# ------------------------------------------------------------------------------
# Add a Food to the foods table
# ------------------------------------------------------------------------------
# Step 1: Display an empty form
get "/add_food" do
  erb :"food/add_food"
end

# Step 2: Save new food information to database if it's valid
#   - Create a Food Object using information entered in form
#   - Runs the add_to_database method, running the validity check
get "/save_new_food" do
  new_food = Food.new({"name" => params["foods"]["name"], "category_id" => params["foods"]["category_id"].to_i})

  if new_food.add_to_database
    erb :"food/success"
  else
    @error = true
    erb :"food/add_food"
  end
end

# ------------------------------------------------------------------------------
# Display foods form for users to select available food items
# ------------------------------------------------------------------------------
# Step 1: Empty food form displaying all food choices
get "/select_food" do
  erb :"food/select_food"
end
# Step 2: Display the recipes that the user can make
get "/get_recipes" do
  if params["foods"].nil?
    @error = true
    erb :"food/select_food"
  else
    list = params["foods"]["food_id"]

    @food_list = []
    list.each do |food|
      food = Food.find(food)
      @food_list << food.name
    end

    @recipes_percentages = Food.recipes(params["foods"]["food_id"])
    recipe_ids = @recipes_percentages.keys
    @recipes_to_make = Recipe.get_names(recipe_ids)
    erb :"food/get_recipes"
  end
end
