#Hash representing Game official board
board = {
	'0' => %w[0 1 2 3],
	'a' => %w[a - - -],
	'b' => %w[b - - -],
	'c' => %w[c - - -]
}

#Game board used for the example
eg_board = {
	'0' => %w[0 1 2 3],
	'a' => %w[a - - -],
	'b' => %w[b - - -],
	'c' => %w[c - - -]
}

#show_board() displays the current state of the board
def show_board(board)
	board.values.each do |row|
		p row
	end
end

#make_move() takes the current player, the chosen move and applies the move to the game board
def make_move(player, move, board)
	choice = move.split("")
	row = board[choice[0]]
	row[choice[1].to_i] = player
end

#decide() is used by the computer to randomly choose a move to apply to the board.
def decide
	rows = %w[a b c]
	slots = %w[1 2 3]
	return rows.sample + slots.sample
end

#valid_move?() takes a move and the current board state and checks if the move is allowed
def valid_move?(move, board)
	choice = move.split("") #returns an array. For example: ["a", "1"]

	if ["a", "b", "c"].include?(choice[0]) && ["1", "2", "3"].include?(choice[1])		
		row = board[choice[0]] #returns the value in the board hash using the key from choice array

		if row[choice[1].to_i] == "-"
			return true
		else
			return false
		end
	else
		return false
	end
end

#board_has_slot?() is used to check if the board is has an empty slot to continue game play.
def board_has_slot?(board)
	board.values.each do |rows|
		total = rows.count("-")
		if total > 0
			return true
		end
	end
	return false
end

#who_won?() does three tests to see who has won a game
def who_won?(board)
	def vertical_test(board) #vertical test, test all columns for a match and returns true & player if a vertical match is found
		a1, b1, c1 = board["a"][1], board["b"][1], board["c"][1]
		a2, b2, c2 = board["a"][2], board["b"][2], board["c"][2]
		a3, b3, c3 = board["a"][3], board["b"][3], board["c"][3]

		if (a1 == b1 && a1 == c1 && (a1 == "X" || a1 == "O"))
			return [true, a1]
		end

		if (a2 == b2 && a2 == c2 && (a2 == "X" || a2 == "O"))
			return [true, a2]
		end

		if (a3 == b3 && a3 == c3 && (a3 == "X" || a3 == "O"))
			return [true, a3]
		end

		return [false,nil]
	end

	def horizontal_test(board) #horizontal test, test all rows for a match and returns true & player if a vertical match is found
		a1, a2, a3 = board["a"][1], board["a"][2], board["a"][3]
		b1, b2, b3 = board["b"][1], board["b"][2], board["b"][3]
		c1, c2, c3 = board["c"][1], board["c"][2], board["c"][3]

		if (a1 == a2 && a1 == a3 && (a1 == "X" || a1 == "O"))
			return [true, a1]
		end

		if (b1 == b2 && b1 == b3 && (b1 == "X" || b1 == "O"))
			return [true, b1]
		end

		if (c1 == c2 && c1 == c3 && (c1 == "X" || c1 == "O"))
			return [true, c1]
		end

		return [false,nil]			
	end

	def diagonal_test(board) #diagonal test, test both diagonals for a match and returns true & player if a vertical match is found
		a1, b2, c3 = board["a"][1], board["b"][2], board["c"][3]
		a3, b2, c1 = board["a"][3], board["b"][2], board["c"][1]

		if (a1 == b2 && a1 == c3 && (a1 == "X" || a1 == "O"))
			return [true, a1]
		end

		if (a3 == b2 && a3 == c1 && (a3 == "X" || a3 == "O"))
			return [true, a3]
		end

		return [false,nil]
	end

	v = vertical_test(board)
	h = horizontal_test(board)
	d = diagonal_test(board)

	if v[0]
		return v[1]
	elsif h[0]
		return h[1]
	elsif d[0]
		return d[1]
	else
		return nil
	end
end

#Loop used to play with computer...
def play_computer(board, player)
	while board_has_slot?(board) do
		if player == $human
			puts ""
			print "Enter your move (T to terminate game): "
			move = gets.strip.downcase

			if move == "t"
				puts "Thank you for playing"
				break
			elsif valid_move?(move, board)
				make_move(player, move, board)
				puts ""
				show_board(board)

				won = who_won?(board)
				if won != nil
					puts "The game is over. The winner is: #{won}!!! Congratulations!"
					break
				end

				player = $computer
			else
				puts "That move is in-valid"
				next
			end
		else
			move = decide
			if valid_move?(move, board)
				puts ""
				puts "Ok... Hmm... Thinking"
				sleep(5)
				make_move(player, move, board)
				puts "Here's MY move: #{move}"
				sleep(2)
				show_board(board)
				
				won = who_won?(board)
				if won != nil
					puts "The game is over. The winner is: #{won}!!! Congratulations!"
					break
				end

				player = $human
			else
				next
			end
		end
	end
end

#Loop used to play another human...
def play_human(board, player)
	while board_has_slot?(board) do
		if player == $player_1
			puts ""
			print "Enter your move player 1 (T to terminate game): "
			move = gets.strip.downcase

			if move == "t"
				puts "Thank you for playing"
				break
			elsif valid_move?(move, board)
				make_move(player, move, board)
				puts ""
				show_board(board)

				won = who_won?(board)
				if won != nil
					puts "The game is over. The winner is: #{won}!!! Congratulations!"
					break
				end

				player = $player_2
			else
				puts "That move is in-valid"
				next
			end
		else
			puts ""
			print "Enter your move player 2 (T to terminate game): "
			move = gets.strip.downcase

			if move == "t"
				puts "Thank you for playing"
				break
			elsif valid_move?(move, board)
				make_move(player, move, board)
				puts ""
				show_board(board)

				won = who_won?(board)
				if won != nil
					puts "The game is over. The winner is: #{won}!!! Congratulations!"
					break
				end

				player = $player_1
			else
				puts "That move is in-valid"
				next
			end
		end
	end
end



#Formal start to game play
print "Please select your player(X or O): "
$human = gets.strip.upcase
$player_1 = $human

if $human == "X"
	$computer = "O"
	$player_2 = "O"
else
	$computer = "X"
	$player_2 = "X"
end

puts ""
puts "You are: #{$human}, Your opponent is: #{$computer}"

puts "The grid below is the game board"
puts ""
show_board(board)

puts ""
puts "Each row is labeled, a through c"
puts "Each column is labeled, 1 through 3"
puts "An available slot will be marked as '-'"
puts "Choose a slot by entering its location."
puts "Example: Entering 'c1' would mark '#{$human}' in the lower left corner"

make_move($human, "c1", eg_board)

puts ""
show_board(eg_board)

puts ""
puts "Single player game(vs the computer) or 2 player(against another human)? (Enter S or 2): "
num_of_players = gets.strip.upcase

if num_of_players == "S"	
	print "Do you wish to play first? (y/n) "
	first = gets.strip.downcase
	first == "y" ? player = $human : player = $computer

	puts""
	puts "Ok!"
	puts "Let's begin!"
	puts ""

	show_board(board)

	play_computer(board, player)
else
	print "Do you wish to play first? (y/n) "
	first = gets.strip.downcase
	first == "y" ? player = $player_1 : player = $player_2

	puts""
	puts "Ok!"
	puts "Let's begin!"
	puts ""

	show_board(board)

	play_human(board, player)
end

puts "The game has ended!"