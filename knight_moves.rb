#board constants
BOARD_X = 0..7
BOARD_Y = 0..7
ELIGIBLE_MOVES = [[1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2]]

class Knight_Move_Tree
  attr_accessor :position
  def initialize(position)
    @position = position
  end

  

end


class KnightNode
  attr_accessor :position
  attr_reader :target
  def initialize(position, target)
    @position = position
    @target = target
    @potential_moves = find_moves(position)
  end

  
  def find_moves(starting_position = @position)
    #find all legal moves from the starting position
    x_pos = starting_position[0]
    y_pos = starting_position[1]
    moves = []
    ELIGIBLE_MOVES.each do |move|
      x_move = move[0]
      y_move = move[1]
      potential_new_space = [(x_pos + x_move), (y_pos + y_move)]
      if(on_game_board?(potential_new_space))
        puts "pushing #{potential_new_space}"
        moves.push(potential_new_space)
      end
    end
    return moves
  end 

  def on_game_board?(position)
    #simple helper function to determine if the space passed in, is on the legal board
    # if((BOARD_X.include?(position[0]) && BOARD_Y.include?(position[1]))
    if((BOARD_X.include?(position[0])) && (BOARD_Y.include?(position[1])))
      return true
    else
      return false
    end
  end

end

start = [7,7]
test_node = KnightNode.new(start, [4,3])

print test_node.find_moves