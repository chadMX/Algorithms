# Nearest Neighbour Solution

v = ['b','c','d','e'] #Vertices
a = [['b','c'],['b','d'],['b','e'],['c','d'],['c','e'],['e','d']] #Edges
c = [5,20,6,7,3,8] #Costs
g = [a,v] #Graph
h = {
   'b'=>50,
   'c'=>30,
   'd'=>0,
   'e'=>41
} #Heuristics

paths = {} #Path Costs
visited = [] #Visited vertices
deadend = [] #Vertices that are dead ends(Loop avoidance).

current = v[0] #Start at the first vertex, B
finish = v[2] #Finish at vertex, D

=begin
 The below iteration uses the index of each edge to find
 its corresponding path in the cost array. Then appends it to the paths array.
=end

a.each{ |e|
   i = a.index(e)
   ci = c[i]
   paths[e] = ci
}

# p paths or puts paths.inspect
# {["b", "c"]=>5, ["b", "d"]=>20, ["b", "e"]=>6, ["c", "d"]=>7, ["c", "e"]=>3, ["e", "d"]=>8} Paths hash when inspected.