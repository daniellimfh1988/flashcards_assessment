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

get '/deck' do
  @available_decks = Deck.all
erb :deck
end

get '/flashcards/:id' do
  @deck = Deck.find(params[:id])
  session[:deck_id] = @deck.id
  @round = current_user.rounds.create(deck_id: session[:deck_id])
  session[:round_id]=@round.id
  # @card = @deck.cards.all #activrecord placement to obtain deck of cards
erb :start_game
end

get '/play_game/guess' do
  @card = Deck.find(session[:deck_id]).cards.all
  @random_card = @card.order("RANDOM()").first
  session[:card_id] = @random_card.id
  @round = Round.find(session[:round_id]) #need this for play_game.erb to display round number
erb :play_game
end

post '/play_game/guess' do
  @round=Round.find(session[:round_id])
  @guess = @round.guesses.create(card_id: session[:card_id],user_input: params[:user_input], result: "TBC")
  @random_card = Card.find(session[:card_id])
  byebug
  if @random_card.language_two == params[:user_input]
    @guess.update(result: "Correct")
  else
    @guess.update(result: "Wrong")
    byebug
  end
  if @round.guesses.count <3
    redirect to("/play_game/guess")
  else
    redirect to '/result_game'
    byebug
end
end

get '/result_game' do
  @results= Guess.where(round_id: session[:round_id])
  @rounds=current_user.rounds
  byebug
erb :result_game
end

# get results game

# post '/deck' do
#     @deck =
#     session[:deck_id] = @user_login.id
#     redirect to("/flashcards/<%=deck.id%>/game")
# end