require_relative 'battleship'

battleship = Battleship.new

opponent = Battleship.new
opponent.fill_out_board

puts "Welcome to Battleship!"

puts "Would you like to [1]. fill out your board yourself, or [2]. have the computer fill out the board for you?"
input = gets.chomp.to_i

if input == 1
	until battleship.no_ships_available
		battleship.display_ships
		puts "Here is your current board:"
		battleship.display_board

		puts "Please pick the name of a ship to place on your board"
		ship = gets.chomp
		puts "Where woyld you like to place it?"
		location = gets.chomp.split('') 
		puts "Would you like the ship to be placed horizontally or vertically? (Enter 0 for horizontal or 1 for vertical)"
		direction = gets.chomp.to_i
		battleship.place_ships(location[0], location[1].to_i, ship, direction)
	end
else
	battleship.fill_out_board
	p battleship.ship_locations
	battleship.display_board
end

puts "Your board is ready to go!"

until battleship.ships_remaining == 0 || opponent.ships_remaining == 0
	puts "Here is your opponent's board:"
	battleship.display_opponent_board

	puts "It's your turn. You have #{battleship.ships_remaining} shots."
	battleship.ships_remaining.times do 
		puts "Pick a location to bomb."
		location = gets.chomp
		battleship.update_notes(opponent.hit?(location.slice(0), (location.slice(1...location.length)).to_i), location.slice(0), location.slice(1...location.length).to_i)
	end
	battleship.display_opponent_board

	break if opponent.ships_remaining == 0

	opponent.ships_remaining.times do
		column = opponent.board.keys.sample
		row = 1 + rand(10) 
		opponent.update_notes(battleship.hit?(column, row), column, row)
	end

	puts "Here are the shots your opponent made:"
	battleship.display_board
end

if opponent.ships_remaining == 0
	puts "You're the winner!"
else
	puts "The computer won."
end





