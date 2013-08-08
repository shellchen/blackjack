require "pry"

myscore = 0
dealerscore = 0
onhands = []
dealerhands = []
deck = []
$alive = true
$playeraction = true

def reset
  suits = ['H', 'D', 'S', 'C']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  suits.product(cards).shuffle
end

def feedcard(deck)
  deck.pop
end

#from solution
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
onhands << feedcard(deck)
dealerhands << feedcard(deck)
onhands << feedcard(deck)
dealerhands << feedcard(deck)
myscore = calculate_score(onhands)
dealerscore = calculate_score(dealerhands)

puts "On my hands are #{onhands[0]}, #{onhands[1]}."
puts "Dealer show #{dealerhands[1]}."
puts "My score is #{myscore}."
puts "hit / stay"

while $alive
  choice = gets.chomp if $playeraction

  if choice == "hit" && dealerscore < 17
    onhands << feedcard(deck)
    puts "You get #{onhands.last}"
    myscore = calculate_score(onhands)
    dealerhands << feedcard(deck)
    dealerscore = calculate_score(dealerhands)
  elsif choice == "hit" && dealerscore >= 17
    onhands << feedcard(deck)
    puts "You get #{onhands.last}"
    myscore = calculate_score(onhands)
  elsif dealerscore < 17
    dealerhands << feedcard(deck)
    dealerscore = calculate_score(dealerhands)
    $playeraction = false
  else
    $alive = false
    $playeraction = false
  end

  if myscore >= 21 || dealerscore >= 21
    $alive = false
  end

  puts "Your score is #{myscore}."
end
puts "==================="
puts "Dealer score is #{dealerscore}."
puts "Your score is #{myscore}."