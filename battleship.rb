class Battleship

	def initialize
		empty_row = [0,0,0,0,0,0,0,0,0,0]
		@board = {
			"A" => empty_row.dup,
			"B" => empty_row.dup,
			"C" => empty_row.dup,
			"D" => empty_row.dup,
			"E" => empty_row.dup,
			'F' => empty_row.dup,
			'G' => empty_row.dup, 
			"H" => empty_row.dup,
			"I" => empty_row.dup, 
			"J" => empty_row.dup
		}
		@fleet_of_ships = {
			"Carrier" => [5,1],
			"Battleship" => [4,1],
			"Cruiser" => [3,1],
			"Destroyer" => [2,2],
			"Submarine" => [1,2]
		}
		@ship_locations = {}
		empty_row_opponent = ['_','_','_','_','_','_','_','_','_','_']
		@opponent_board = {
			"A" => empty_row_opponent.dup,
			"B" => empty_row_opponent.dup,
			"C" => empty_row_opponent.dup,
			"D" => empty_row_opponent.dup,
			"E" => empty_row_opponent.dup,
			'F' => empty_row_opponent.dup,
			'G' => empty_row_opponent.dup, 
			"H" => empty_row_opponent.dup,
			"I" => empty_row_opponent.dup, 
			"J" => empty_row_opponent.dup
		}

		@ships_remaining = 0
		@fleet_of_ships.each do |ship, ship_values|
			@ships_remaining += ship_values[1]			
		end
	end 

	attr_reader :board, :fleet_of_ships, :ships_remaining, :ship_locations

	def place_ships(column, row, ship, direction)
		columns = @board.keys
		if row < 1 || row > 10 || !columns.include?(column) || @fleet_of_ships[ship][1] == 0 || !placement_valid?(column, row, ship, direction)
			return 
		end

		@ship_locations["#{column}#{row}"] = []

		if direction == 0
			column_index = columns.index(column)
			initial_column_index = column_index
			until column_index == initial_column_index + @fleet_of_ships[ship][0]
				@board[columns[column_index]][row - 1] = 1
				@ship_locations["#{column}#{row}"].push("#{columns[column_index]}#{row}")
				column_index += 1
			end
		else
			initial_row = row
			until row == initial_row + @fleet_of_ships[ship][0] 
				@board[column][row - 1] = 1
				@ship_locations["#{column}#{initial_row}"].push("#{column}#{row}")
				row += 1
			end
		end
		@fleet_of_ships[ship][1] -= 1
	end

	def display_board
		return_value = "  "
		columns = @board.keys
		columns.each do |column|
			return_value += column + " "
		end
		puts return_value
		return_value = ""
		(0..9).each do |row|
			columns.each do |column|
				 return_value += @board[column][row].to_s + " "
			end
			puts (row+1).to_s + " " + return_value
			return_value = ""
		end
	end

	def display_opponent_board
		return_value = "  "
		columns = @opponent_board.keys
		columns.each do |column|
			return_value += column + " "
		end
		puts return_value
		return_value = ""
		(0..9).each do |row|
			columns.each do |column|
				 return_value += @opponent_board[column][row].to_s + " "
			end
			puts (row+1).to_s + " " + return_value
			return_value = ""
		end
	end

	def display_ships
		string = []
		@fleet_of_ships.each do |name, array|
			string << "#{name}(#{array[0]})x#{array[1]}"
		end
		p "These are your available ships: " + string.join(", ")
	end

	def no_ships_available
		@fleet_of_ships.each do |ship, ship_values|
			if ship_values[1] > 0 
				return false 
			end
		end
	end

	def fill_out_board 
		until no_ships_available
			column = @board.keys.sample
			row = 1 + rand(10)
			ship = @fleet_of_ships.keys.sample

			until @fleet_of_ships[ship][1] > 0
				ship = @fleet_of_ships.keys.sample
			end

			direction = rand(2)
			place_ships(column, row, ship, direction)
		end
	end

	def hit?(column, row)
		if @board[column][row-1] == 1 
			@board[column][row-1] = 'X'
			@ship_locations.each do |key, locations|
				if locations.include?("#{column}#{row}")
					count = 0
					locations.each do |location| 
						if @board[location.slice(0)][location.slice(1...location.length).to_i - 1] == 'X'
							count += 1
						end
					end
					if count == locations.length
						@ships_remaining -= 1
					end
				end
			end

			return true
		else
			@board[column][row-1] = '/'
			return false
		end
	end



	def update_notes(hit, column, row)
		if hit 
			@opponent_board[column][row-1] = 'X'
		else
			@opponent_board[column][row-1] = '/'
		end
	end

	private

	def placement_valid?(column, row, ship, direction)
		if direction == 0
			columns = @board.keys
			column_index = columns.index(column)
			return column_index + @fleet_of_ships[ship][0] < columns.length && !intersection(column, row, ship, direction)
		else
			return (row - 1) + @fleet_of_ships[ship][0] < 10 && !intersection(column, row, ship, direction)
		end
	end

	def intersection(column, row, ship, direction)
		if direction == 0
			columns = @board.keys
			column_index = columns.index(column)
			initial_column_index = column_index
			until column_index == initial_column_index + @fleet_of_ships[ship][0]
				if @board[columns[column_index]][row - 1] == 1 
					return true
				end
				column_index += 1
			end
		else
			initial_row = row
			until row == initial_row + @fleet_of_ships[ship][0] 
				if @board[column][row - 1] == 1
					return true
				end
				row += 1
			end
		end
	end

end


