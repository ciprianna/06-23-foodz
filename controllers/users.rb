# ------------------------------------------------------------------------------
# Add a new user
# ------------------------------------------------------------------------------
# Step 1 - Display empty form to user
get "/new_user" do
  erb :"users/new_user"
end

# Step 2 - Save form information
get "/save_new_user" do
  new_user = User.new({"email" => params["users"]["email"], "password" => params["users"]["password"]})

  @user_added = new_user.add_to_database
  if @user_added != false
    erb :"users/success"
  else
    @error = true
    erb :"users/new_user"
  end
end
