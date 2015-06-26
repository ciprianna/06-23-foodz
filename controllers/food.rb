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
# Step 2: Send the form to a save file in the recipes section
#   Route handler in the controller recipe file.
