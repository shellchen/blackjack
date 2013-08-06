myscore = 0
dealerscore = 0
onhands = []
dealerhands = []
deck = []

def reset
  suits = ['H', 'D', 'S', 'C']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  suits.product(cards).shuffle
end

def feedme(deck, onhands)
  onhands << deck.pop
end

def feeddealer(deck, dealerhands)
  dealerhands << deck.pop
  0
end

def calculate_score(playercards)
  score = 0
  ary = playercards.map{ |element| element[1] }
  ary.each do |value|
    if value == "A"
      score += 11
    elsif value.to_i == 0
      score += 10
    else
      score += value.to_i
    end
  end

  ary.select{ |element| element == "A" }.count.times do
    score -= 10 if score > 21
  end

  score
end

deck = reset()
feedme(deck, onhands)
feeddealer(deck, dealerhands)
feedme(deck, onhands)
feeddealer(deck, dealerhands)
myscore = calculate_score(onhands)
dealerscore = calculate_score(dealerhands)

puts "On my hands are #{onhands[0]}, #{onhands[1]}."
puts "Dealer show #{dealerhands[1]}."
puts "My score is #{myscore}."
puts "hit / stay"
choice = gets.chomp

if choice == "hit"
  feedme(deck, onhands)
  myscore = calculate_score(onhands)
  
  feeddealer(deck, dealerhands) if dealerscore < 17
  dealerscore = calculate_score(dealerhands)
  puts "Dealer score is #{dealerscore}."
  puts "Your score is #{myscore}."
else
  feeddealer(deck, dealerhands) if dealerscore < 17
  dealerscore = calculate_score(dealerhands)
  puts "Dealer score is #{dealerscore}."
  puts "Your score is #{myscore}."
end