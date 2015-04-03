@deck = Deck.create(name: "English-Indonesian")

array = []
IO.foreach("db/english-indonesian.txt") do |x|
  array << x.downcase.split(' ')
end

array.each do |word|
  @card = Card.create(deck_id: 1, language_one: word[0], language_two: word[1])
end


@deck = Deck.create(name: "English-Malaysian")

array = []
IO.foreach("db/english-malaysian.txt") do |x|
  array << x.downcase.split(' ')
end

array.each do |word|
  @card = Card.create(deck_id: 2, language_one: word[0], language_two: word[1])
end