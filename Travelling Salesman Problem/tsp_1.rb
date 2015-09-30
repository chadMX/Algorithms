# Nearest Neighbour Solution

v = ['Kingston','Clarendon','St.Ann','Westmorland'] #Vertices
a = [['Kingston','Clarendon'],['Kingston','St.Ann'],['Kingston','Westmorland'],['Clarendon','St.Ann'],['Clarendon','Westmorland'],['Westmorland','St.Ann']] #Edges
c = [5,20,6,7,3,8] #Costs/Distance/Length
g = [v,a] #Graph


####################################################################################
####################################################################################


# Greedy Best First Solution

v = ['Kingston','Clarendon','St.Ann','Westmorland'] #Vertices
a = [['Kingston','Clarendon'],['Kingston','Westmorland'],['Clarendon','St.Ann'],['Clarendon','Westmorland'],['Westmorland','St.Ann']] #Edges

h = {
   'Kingston'=>50,
   'Clarendon'=>30,
   'St.Ann'=>0,
   'Westmorland'=>41
} #Heuristics


####################################################################################
####################################################################################



def tsp_nns(vertices, edges, costs)
   paths = {} #Path Costs
   visited = [] #Visited vertices
   #deadend = [] Vertices that are dead ends(Loop avoidance) NOT USED IN SOLUTION
   
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
   
=begin
   paths hash after inspection:
   {
      ["Kingston", "Clarendon"]=>5,
      ["Kingston", "St.Ann"]=>20,
      ["Kingston", "Westmorland"]=>6,
      ["Clarendon", "St.Ann"]=>7,
      ["Clarendon", "Westmorland"]=>3,
      ["Westmorland", "St.Ann"]=>8
   }
=end
   
   
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
   
   # End travelling
   
   if visited[-1] == goal
      puts "*******"
      puts "Success using nearest neighbour!"
      puts "*******"
   end
   
   puts "Visited vertices:"
   puts visited
end

def tsp_gbfs(vertices, edges, heuristic)
   parent_children = {} #Parent-Children
   visited = [] #Visited vertices
   #deadend = [] Vertices that are dead ends(Loop avoidance) NOT USED IN SOLUTION
   
   current = v[0] #Start at the first vertex, Kingston
   goal = v[2] #Finish at vertex, St.Ann
   
   
   v.each{ |vertex|
      children = []
      a.each{ |edge|
         if vertex == edge[0]
            children << edge[1]
         end
      }
   
      parent_children[vertex] = children
   }
   
=begin
   parent-children hash after inspection:
   {
   "Kingston"=>["Clarendon","Westmorland"],
   "Clarendon"=>["St.Ann", "Westmorland"], "St.Ann"=>[],
   "Westmorland"=>["St.Ann"]
   }
=end
   
   
   # Begin travelling using nearest to goal heuristic
   
   while current != goal do
      worst_choice = 2**30
   
      if !visited.include?(current)
         visited << current
      end
   
      next_parish = ""
   
      parent_children[current].each{ |parish|
         length = h[parish]
         if length < worst_choice
            worst_choice = length
            next_parish = parish
         end
      }
   
      current = next_parish
   
      visited << current
   
      if current == goal
         break
      end
   end
   
   if visited[-1] == goal
      puts
      puts "*******"
      puts "Success using Greedy best first search!"
      puts "*******"
   end
   
   puts "Visited vertices:"
   puts visited
   
   # End travelling
end