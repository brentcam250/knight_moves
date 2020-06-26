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

  # def level_tree(starting_node = @root_node)
  #   # until @graph_contains_target
  #     traverse_level(starting_node)

  #   # end

  # end

  def traverse_level(starting_node = @root_node)
    #traverse the tree in level order until the target is found
    #this method also builds the next level in the tree when it is required.
    output = []
    queue = []
    queue.push(starting_node)
    while(queue.length > 0) 
      current_node = queue.shift
      # puts "traversing level #{current_node}"
      if(current_node.is_target?(current_node.position, @target))
        puts "found the target in #{current_node}"
        return
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

  end






  def find_path(previously_visited = [], current_node = @root_node, target = @target )
    if(current_node.position == target)
      return [previously_visited, current_node]
    elsif (current_node.children)
      previously_visited.push(current_node)
      current_node.children.each do |child|
        find_path(previously_visited, child)
      end
    else
      # puts "shoot"
    end

  end

#   def find_with_parent(starting_node = @root, parent_node = nil, value)
#     #find value, return array of nodes 
#     #first value is the parent, second is the node with the target value
#     #with the value, or false if not found
#     #use recursion to search through sub trees
    
#     if(value == starting_node.data)

#       return [parent_node, starting_node]

#     elsif(value < starting_node.data)

#       unless(starting_node.left_child.nil?)
#         find_with_parent(starting_node.left_child, starting_node, value)
#       else
#         return false
#       end

#     else

#       unless(starting_node.right_child.nil?)
#         find_with_parent(starting_node.right_child, starting_node, value)
#       else
#         return false
#       end

#     end
# end



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

  def make_children_nodes
    children = []
    @moves.each do |move|
      child = KnightNode.new(move)
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
    output = "KNIGHTNODE: position: #{@position} moves: #{@moves} children #{@children ? "number of children = #{@children.length} they are : #{@children} ": "nil"}" 
  end

end

start = [0,0]
target = [7,7]
# test_node = KnightNode.new(start, target)

# print test_node.find_moves

tree = Knight_Move_Tree.new(start, target)

# tree.build_tree

tree.traverse_level
path = tree.find_path
puts "\n\nfound the square in #{path.length-1} moves! \n\n"
# puts "\n\npath: #{tree.find_path}"

path.each do |node|
  puts "position: #{node.position}"
end