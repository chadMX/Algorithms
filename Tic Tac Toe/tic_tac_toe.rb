def arena(player, choice, previous_moves)
   a = [" "," "," "]
   b = [" "," "," "]
   c = [" "," "," "]
   
   board = {
      'a' => a,
      'b' => b,
      'c' => c
   }
   
   board.each{ |str, row|
      if str == choice[0]
         if [0,1,2].include?(choice[1].to_i)
            row[choice[1].to_i] = player
            break
         end
      end
   }
   
   previous_moves.each{ |move|
      player2 = move[0]
      choice2 = move[1]
      board.each{ |str, row|
         if str == choice2[0]
            if [0,1,2].include?(choice2[1].to_i)
               row[choice2[1].to_i] = player2
               break
            end
         end
      }
   }
   
   board.each{ |str, row| p row}
end