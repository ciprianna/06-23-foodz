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
  new_food = Food.new({"name" => params["name"], })

  if new_food.add_to_database
    erb :"main/success"
  else
    @error = true
    erb :"food/add_food"
end
