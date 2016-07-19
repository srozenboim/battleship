require_relative '../battleship'

describe 'battleship' do
	let(:battleship) { Battleship.new }
	let(:empty_board) { { "A" => [0,0,0,0,0,0,0,0,0,0],
										"B" => [0,0,0,0,0,0,0,0,0,0],
										"C" =>[0,0,0,0,0,0,0,0,0,0],
										"D" =>[0,0,0,0,0,0,0,0,0,0],
										"E" =>[0,0,0,0,0,0,0,0,0,0],
										"F" =>[0,0,0,0,0,0,0,0,0,0],
										"G" =>[0,0,0,0,0,0,0,0,0,0],
										"H" =>[0,0,0,0,0,0,0,0,0,0],
										"I" =>[0,0,0,0,0,0,0,0,0,0],
										"J" =>[0,0,0,0,0,0,0,0,0,0]
		} }
	let(:horizontal_ship) { { "A" => [0,0,0,0,0,0,0,0,0,0],
										"B" => [0,0,0,0,0,0,0,0,0,0],
										"C" =>[0,0,0,0,0,0,0,0,0,0],
										"D" =>[1,0,0,0,0,0,0,0,0,0],
										"E" =>[1,0,0,0,0,0,0,0,0,0],
										"F" =>[1,0,0,0,0,0,0,0,0,0],
										"G" =>[1,0,0,0,0,0,0,0,0,0],
										"H" =>[1,0,0,0,0,0,0,0,0,0],
										"I" =>[0,0,0,0,0,0,0,0,0,0],
										"J" =>[0,0,0,0,0,0,0,0,0,0]
		}}
	let(:vertical_ship) { { "A" => [0,0,0,0,0,0,0,0,0,0],
										"B" => [0,0,0,0,0,0,0,0,0,0],
										"C" =>[0,0,0,0,0,0,0,0,0,0],
										"D" =>[1,1,1,1,1,0,0,0,0,0],
										"E" =>[0,0,0,0,0,0,0,0,0,0],
										"F" =>[0,0,0,0,0,0,0,0,0,0],
										"G" =>[0,0,0,0,0,0,0,0,0,0],
										"H" =>[0,0,0,0,0,0,0,0,0,0],
										"I" =>[0,0,0,0,0,0,0,0,0,0],
										"J" =>[0,0,0,0,0,0,0,0,0,0]
		}}

context '#initialize' do
	it 'has an empty board' do
		expect(battleship.board).to match (empty_board)
	end 

	it 'has a fleet of ships' do
		expect(battleship.fleet_of_ships).to match ({
			"Carrier" => [5,1],
			"Battleship" => [4,1],
			"Cruiser" => [3,1],
			"Destroyer" => [2,2],
			"Submarine" => [1,2]
		})
	end

	it 'has 7 ships remaining' do
		expect(battleship.ships_remaining).to eq 7
	end
end 

context '#place_ships' do
	it 'places the ship horizontally if the placement is valid and there is no intersection' do
		battleship.place_ships("D", 1, "Carrier", 0)
		expect(battleship.board).to match (horizontal_ship)
	end

	it 'places the ship vertically if the placement is valid and there is no intersection' do
		battleship.place_ships("D", 1, "Carrier", 1)
		expect(battleship.board).to match (vertical_ship)
	end

	it 'does not place the ship horizontally if it is going off the board' do
		battleship.place_ships("H", 1, "Carrier", 0)
		expect(battleship.board).to match (empty_board)
	end

	it 'does not place the ship vertically if it is going off the board' do
		battleship.place_ships("H", 8, "Carrier", 1)
		expect(battleship.board).to match (empty_board)
	end

	it 'does not place the ship vertically if there is an intersection' do
		battleship.place_ships("D", 1, "Carrier", 0)
		battleship.place_ships("D", 1, "Carrier", 1)
		expect(battleship.board).to match (horizontal_ship)
	end

		it 'does not place the ship horizontally if there is an intersection' do
		battleship.place_ships("D", 1, "Carrier", 1)
		battleship.place_ships("D", 1, "Carrier", 0)
		expect(battleship.board).to match (vertical_ship)
	end


end

end