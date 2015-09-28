# Greedy algorithm(Nearest Neighbour Solution)

v = ['b','c','d','e'] #Vertices
a = [['b','c'],['b','d'],['b','e'],['c','d'],['c','e'],['e','d']] #Edges
c = [5,20,6,7,3,8] #Costs
g = [a,v] #Graph
paths = [] #Path Costs

start = v[0]
finish = v[2]

=begin
 The below iteration uses the index of each edge to find
 its corresponding path in the cost array. Then appends it to the paths array.
=end

a.each{ |e|
   i = a.index(e)
   ci = c[i]
   paths << e + [ci]
}