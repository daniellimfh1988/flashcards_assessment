
#guess
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
  if @random_card.language_two == params[:user_input].downcase
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
