#board constants
BOARD_X = 0..7
BOARD_Y = 0..7

# BOARD_X = 0..3
# BOARD_Y = 0..3

ELIGIBLE_MOVES = [ [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2] ]

class Knight_Move_Tree
  attr_accessor :position, :graph_contains_target
  def initialize(position, target)
    @root_node = KnightNode.new(position)
    # @children = nil 
    @target = target
    @graph_contains_target = false

  end

  def build_tree(starting_node = @root_node)
    #use this function to continue building new nodes, until we've found the target. 
    #then we can use this tree to find the path, and the number of moves to target

    # 10.times do
    until @graph_contains_target
      moves = starting_node.moves
      #at this stage, the children are actually just an array of positions, not an array of nodes.
      children_of_starting_node = []
      moves.each do |move| 
        # if(@graph_contains_target)
        #   #we can ignore the rest of the potential moves array as we've already found our target
        #   next
        # end
        #loop over the array of eligible moves, make a node, and set the current nodes children = to the node array here.
        move_node = KnightNode.new(move)
        children_of_starting_node.push(move_node)
        #make a node and push it onto this array.
        # puts move_node.is_target?(move_node.position, @target)
        # puts "move = #{move} target = #{@target}"
        starting_node.children = children_of_starting_node

        if(move_node.is_target?(move, @target))
          @graph_contains_target = true
          puts "\n\n\nyay found it\n\n\n"
          puts "starting node = #{starting_node} "
          puts "move node = #{move_node}"
        else
          puts "starting node = #{starting_node} "
          puts "move node = #{move_node}"
          build_tree(move_node)

          
        end
      end

      
    end
  end

  def find_path(previously_visited = [], starting_node = @root_node, target = @target )


  end

  # def build_new_level(starting_node)

  # end

  # def level_order(starting_node)
  #   output = []
  #   queue = []
  #   queue.push[starting_node]
  #   until(starting_node.is_target?)
  #     current_node = queue.shift
  #     output.push(current_node.position)

  #   end
  # end

    # #block is a starting node, reads until the bottom
    # def level_order(block = @root)
    #   #can be either iterative or recursive
    #   output = []
    #   queue = []
    #   queue.push(block)
    #   while(queue.length > 0)
    #     current_node = queue.shift
    #     # puts "printing out kids #{current_node.data}"
    #     output.push(current_node.data)
    #     children = current_node.return_children
    #     if(children)
    #       children.each do |child|
    #         queue.push(child)
    #       end
    #     end
    #   end
    #   return output
    # end
  
  

end


class KnightNode
  attr_accessor :position, :children, :moves
  # def initialize(position, target)
  #   @position = position
  #   @target = target
  #   # @found_target = false
  #   @potential_moves = find_moves(position) unless @found_target
  # end
  
  def initialize(position)
    @position = position
    @moves = find_moves(position)
    @children = nil
  end
  
  def find_moves(starting_position = @position)
    #find all legal moves from the starting position
    #aka the children of the current node in the graph
    x_pos = starting_position[0]
    y_pos = starting_position[1]
    output_moves = []
    ELIGIBLE_MOVES.each do |move|
      x_move = move[0]
      y_move = move[1]
      potential_new_space = [(x_pos + x_move), (y_pos + y_move)]
      if(on_game_board?(potential_new_space))
        # puts "pushing #{potential_new_space} "
        
        # new_position_node = KnightNode.new(potential_new_space)
        # output_moves.push(new_position_node)
        #create a new node and push it onto the output array.

        output_moves.push(potential_new_space)
        # if(is_target?(potential_new_space))
        #   # @found_target = true
        #   puts "YAY WINNER SPACE from #{starting_position} #{potential_new_space} == target #{@target}"
        # end
      end
   end
    return output_moves
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

  def is_target?(position, target)
    if(position == target)
      return true
    else
      return false
    end
  end

  def to_s 
    output = "KNIGHTNODE: position: #{@position} moves: #{@moves} children #{@children ? "number of children = #{@children.length} they are : #{@children} ": "nil"}" 
  end

end

start = [0,0]
target = [7,6]
# test_node = KnightNode.new(start, target)

# print test_node.find_moves

tree = Knight_Move_Tree.new(start, target)

tree.build_tree