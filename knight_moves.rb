#board constants
BOARD_X = 0..7
BOARD_Y = 0..7

# BOARD_X = 0..3
# BOARD_Y = 0..3

ELIGIBLE_MOVES = [ [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2] ]

class Knight_Move_Tree
  attr_accessor :position, :graph_contains_target
  def initialize(position, target)
    @root_node = KnightNode.new(position, nil)
    # @children = nil 
    @target = target
    @graph_contains_target = false

  end

  # def level_tree(starting_node = @root_node)
  #   # until @graph_contains_target
  #     traverse_level(starting_node)

  #   # end

  # end

  def traverse_level(starting_node = @root_node)
    #traverse the tree in level order until the target is found
    #this method also builds the next level in the tree when it is required.
    # output = []
    queue = []
    queue.push(starting_node)
    while(queue.length > 0) 
      current_node = queue.shift
      # puts "traversing level #{current_node}"
      # output.push(current_node.position)
      # puts "currently at #{current_node.position}"
      if(current_node.is_target?(current_node.position, @target))
        # puts "found the target in #{current_node}"
        # puts "output is currently #{output}" 
        # puts "currents parent = #{current_node.parent}"
        return current_node
        # return output
      else
        current_node.make_children_nodes
        # puts "didnt find, heres node #{current_node}"
        # if(current_node.children)
          current_node.children.each do |child|
            queue.push(child)
          end
        # end

      end

    end
    # return output

  end


  def trace_ancestors(current_node)
    #method to trace backwards through the tree from node until the root, 
    #reverses the output to show the path we would need to take from parent to target
    moves = []
    until(current_node.parent.nil?)
      moves.push(current_node.position)
      current_node = current_node.parent
    end
    return moves.reverse
  end



  def find_path(previously_visited = [], current_node = @root_node, target = @target)
    if(current_node.position == target)
      previously_visited.push(current_node)
      return previously_visited
    elsif (current_node.children)
      previously_visited.push(current_node)
      #we've visited this node, need to keep track of that.
      current_node.children.each do |child|
        # puts " child #{child}"
        find_path(previously_visited, child, target)
      end
    else
      # puts "shoot"
    end

  end



  

end


class KnightNode
  attr_accessor :position, :children, :moves, :parent

  def initialize(position, parent)
    @position = position
    @moves = find_moves(position)
    @children = nil
    @parent = parent
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

  def make_children_nodes
    children = []
    @moves.each do |move|
      child = KnightNode.new(move, self)
      children.push(child)
    end
    @children = children
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
    # output = "KNIGHTNODE: position: #{@position} moves: #{@moves} children #{@children ? "number of children = #{@children.length} they are : #{@children} ": "nil"}" 
    output = "KNIGHTNODE: position: #{@position} moves: #{@moves}"
  end

end

start = [0,0]
target = [3,3]
# test_node = KnightNode.new(start, target)

# print test_node.find_moves

tree = Knight_Move_Tree.new(start, target)

# tree.build_tree

target_node = tree.traverse_level

ancestors = tree.trace_ancestors(target_node)


puts "made it from #{start} to #{target} in #{ancestors.length} moves!"
puts "moves = #{ancestors}"
