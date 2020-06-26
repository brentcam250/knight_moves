#board constants
BOARD_X = 0..7
BOARD_Y = 0..7

ELIGIBLE_MOVES = [ [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2] ]

class Knight_Move_Tree
  attr_accessor :position, :graph_contains_target
  def initialize(position, target)
    @root_node = KnightNode.new(position, nil)
    @target = target
    @graph_contains_target = false

  end

  def traverse_level(starting_node = @root_node)
    #traverse the tree in level order until the target is found
    #this method also builds the next level in the tree when it is required.

    queue = []
    queue.push(starting_node)
    while(queue.length > 0) 
      current_node = queue.shift
      if(current_node.is_target?(current_node.position, @target))
        return current_node
      else
        current_node.make_children_nodes

          current_node.children.each do |child|
            queue.push(child)
          end

      end

    end

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
        output_moves.push(potential_new_space)
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



def knight_moves_random()
  x_start = rand(0..7)
  y_start = rand(0..7)
  x_target = rand(0..7)
  y_target = rand(0..7)
  start = [x_start, y_start]
  target = [x_target, y_target]
  tree = Knight_Move_Tree.new(start,target)
  target_node = tree.traverse_level
  path = tree.trace_ancestors(target_node)

  puts "\nmade it from #{start} to #{target} in #{path.length} moves!"
  puts "moves = #{path}"


end

def knight_moves()
  puts "please enter a starting x coordinate"
  x_start = get_coord()
  puts "please enter a starting y coordinate"
  y_start = get_coord()
  puts "please enter a target x coordinate"
  x_target = get_coord()
  puts "please enter a target y coordinate"
  y_target = get_coord()
  start = [x_start, y_start]
  target = [x_target, y_target]
  tree = Knight_Move_Tree.new(start,target)
  target_node = tree.traverse_level
  path = tree.trace_ancestors(target_node)

  puts "\nmade it from #{start} to #{target} in #{path.length} moves!"
  puts "moves = #{path}"


end

def get_coord()
  coord = gets.chomp.to_i
  until((0..7).member?(coord))
    puts "please enter a number from 0 to 7"
    coord = gets.chomp.to_i
  end 
  return coord
end

knight_moves_random()