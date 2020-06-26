finding the shortest path a knight chess piece can take from a given square to another given square.
https://www.theodinproject.com/courses/ruby-programming/lessons/data-structures-and-algorithms?

Method:
given a starting position, find all legal moves from that square with 1 hop. If none of these are the target, find their children, and so on until we have found the target.
this is similar to a breadth first search of a tree.
Once we have located the target in this method, trace back through the parent nodes to find the path that was taken to get to target.
This tracing back through the parents is possible because in the node, I keep track of the parent node as well as children, so it has a two-way relationship. 