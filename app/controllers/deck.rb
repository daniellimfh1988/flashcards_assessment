
#deck
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