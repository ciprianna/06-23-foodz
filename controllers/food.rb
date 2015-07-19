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
  @new_food = Food.create({"name" => params["foods"]["name"], "category_id" => params["foods"]["category_id"].to_i})

  if !@new_food.errors.empty?
    @error = true
    erb :"food/add_food"
  else
    erb :"food/success"
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
    @food_list = Food.find(params["foods"]["food_id"])

    @recipes = []
    @food_list.each do |food|
      @recipes << food.recipes
    end

    recipe_ids = []
    @recipes.each do |recipe_list|
      recipe_list.each do |recipe|
        recipe_ids << recipe.id
      end
    end

    counts = Food.get_counts(recipe_ids)
    recipe_ingredients = Recipe.ingredients(counts)
    @recipes_percentages = Recipe.percentage_of_ingredients(recipe_ingredients, counts)
    erb :"food/get_recipes"
  end
end
