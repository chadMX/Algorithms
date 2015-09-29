# Nearest Neighbour Solution

v = ['Kingston','Clarendon','St.Ann','Westmorland'] #Vertices
a = [['Kingston','Clarendon'],['Kingston','St.Ann'],['Kingston','Westmorland'],['Clarendon','St.Ann'],['Clarendon','Westmorland'],['Westmorland','St.Ann']] #Edges
c = [5,20,6,7,3,8] #Costs/Distance/Length
g = [v,a] #Graph
h = {
   'Kingston'=>50,
   'Clarendon'=>30,
   'St.Ann'=>0,
   'Westmorland'=>41
} #Heuristics Not used in this solution

paths = {} #Path Costs
visited = [] #Visited vertices
deadend = [] #Vertices that are dead ends(Loop avoidance).

current = v[0] #Start at the first vertex, Kingston
goal = v[2] #Finish at vertex, St.Ann

=begin
 The below iteration uses the index of each edge to find
 its corresponding path in the cost array. Then appends it to the paths array.
=end

a.each{ |e|
   i = a.index(e)
   ci = c[i]
   paths[e] = ci
}

# {["Kingston", "Clarendon"]=>5, ["Kingston", "St.Ann"]=>20, ["Kingston", "Westmorland"]=>6, ["Clarendon", "St.Ann"]=>7, ["Clarendon", "Westmorland"]=>3, ["Westmorland", "St.Ann"]=>8}

# Begin travelling using nearest neighbour

while current != goal do
   if !visited.include?(current)
      visited << current
   end

   children = {}

   paths.each{ |edge, length|
      if current == edge[0]
         if !visited.include?(edge[1])
            children[edge[1]] = length
         end
      end
   }

   temp_nearest = 2**30

   children.each{ |child, distance|
      if distance < temp_nearest && !visited.include?(child)
         current = child
         temp_nearest = distance
      end
   }

   visited << current

   if current == goal
      break
   end
end

if visited[-1] == goal
   puts "*******"
   puts "Success using nearest neighbour!"
   puts "*******"
end

puts "Visited vertices:"
puts visited