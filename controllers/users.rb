# ------------------------------------------------------------------------------
# Add a new user
# ------------------------------------------------------------------------------
# Step 1 - Display empty form to user
get "/new_user" do
  erb :"users/new_user"
end

# Step 2 - Save form information
get "/save_new_user" do
  password = BCrypt::Password.create(params["users"]["password"])
  @new_user = User.create({"email" => params["users"]["email"], "password" => password})

  if @new_user.errors.empty?
    session[:user_id] = @new_user.id
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
  @user_email = User.find_by(email: entered_email)

  if !@user_email.nil?
    @valid = true
    given_pw = params["users"]["password"]
    actual_pw = BCrypt::Password.new(@user_email.password)
    if actual_pw == given_pw
      session[:user_id] = @user_email.id
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
