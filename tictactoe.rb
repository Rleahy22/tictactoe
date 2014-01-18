require_relative './lib/game'

puts "Would you like to begin a game? (y/n)"
response = gets.chomp
until response.upcase == "Y" || response.upcase == "N"
  puts "Please enter either y or n"
  response = gets.chomp
end
if response.upcase == "Y"
  @game = Game.new
else
  puts "Then why are you here?"
end
@game.play