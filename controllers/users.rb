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

# ------------------------------------------------------------------------------
# Login
# ------------------------------------------------------------------------------
# Step 1 - Display empty login form
get "/login" do
  erb :"users/login"
end

# Step 2 - Authenticate login
get "/authenticate_login" do
  entered_email = params["users"]["email"]
  user_email = User.find_email(entered_email)

  if !user_email.nil?
    @valid = true
    given_pw = params["users"]["password"]
    actual_pw = BCrypt::Password.new(user_email.password)
    if actual_pw == given_pw
      erb :"main/home"
    else
      @valid = false
      erb :"users/login"
    end
  else
    @valid = false
    erb :"users/login"
  end
end
