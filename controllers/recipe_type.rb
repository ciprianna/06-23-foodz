# ------------------------------------------------------------------------------
# View all recipe types
# ------------------------------------------------------------------------------
get "/view_recipe_types" do
  erb :"recipe_types/view_recipe_types"
end

# ------------------------------------------------------------------------------
# Add new recipe type
# ------------------------------------------------------------------------------
# Step 1: Display empty form
get "/add_recipe_type" do
  erb :"recipe_types/add_recipe_type"
end

# Step 2: Save form information to database
get "/save_new_recipe_type" do
  @added_recipe_type = RecipeType.create({"name" => "#{params['recipetype']['name']}"})

  if !@added_recipe_type.errors.empty?
    @error = true
    erb :"recipe_types/add_recipe_type"
  else
    erb :"recipe_types/success"
  end
end
