get '/flashcards' do
  # Look in app/views/index.erb
  erb :index
end

get '/create_account' do
erb :create_account
end

post '/create_account' do
@account = User.create(params[:person])
redirect to("/flashcards")
end

post '/flashcards' do
  @user_login = User.find_by_username(params[:user_username])
  byebug
  if @user_login.nil?
  # session[:error] = "Invalid username or password"
  #<%if session[:error] %>
#<%=session[:error]%>
#<%end%>
  redirect to '/flashcards'
  elsif @user_login.password == params[:user_password]
    session[:user_id] = @user_login.id
redirect to("/deck")
  end
end

get '/sign_out' do
  erb :sign_out
end

