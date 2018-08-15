# Multi Line / Node MTA
Sadly for programmers most train networks don’t work like the GA MTA - they have lots of lines and lot’s of interconnecting points. Of course it’s possible to get from A to D via B and C in any network, and the simplest way to get the shortest path between any two nodes is Breadth First Search.

Wikipedia: [Breadth-first search - Wikipedia](https://en.wikipedia.org/wiki/Breadth-first_search)
Youtube: [Breadth First Search Algorithm - YouTube](https://www.youtube.com/watch?v=QRq6p9s8NVg)

## Change Node Map into Tree Graph
Here is a simple train network. Let’s start at Frankfurt and convert to a tee graph with each node representing the level of separation from the starting point;

![](https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/MapGermanyGraph.svg/500px-MapGermanyGraph.svg.png)

And here it is. Note that in this example we are not going to consider the distance between stops. For this we would need to care about weighted graphs, which we are not in this example.
![](https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/GermanyBFS.svg/500px-GermanyBFS.svg.png)

## Breadth First
Breadth first means we will examine all of the nodes that are at the same level in the tree before we move onto the next layer (ie, we’ll check all of the children before we move on to the grand-children)

## Breadth First Search
The key concept is that we build a queue of nodes to examine, and keep examining the first item in the queue.
```
While there are items in the queue
	If the node we’re examining is not the destination, then
		Add the current node to the list of examined nodes.
		Add all of it’s descendants to the queue and discard the current node from the queue
```

Here are a couple of pictures which illustrate what I mean:

![](https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Breadth-first-tree.svg/1200px-Breadth-first-tree.svg.png)
![](http://www.stoimen.com/blog/wp-content/uploads/2012/09/2.-BFS-Wave.png)

The two key points are the *queue* of nodes that we are yet to examine and the *list* of nodes we have already examined

We can stop the process once we find the destination node and it has been added to the *list*. At this point our Breadth First Search is done, and our list begins with the start node, ends with the end node, and in between is a list of all of the nodes examined, in the order in which we examined them.


## Building the Path
Now to pick apart the *list* and create a *path* from it. We now have all of the information required to create this shortest path.

```
Starting with the last node in the list, add it to the path and find it’s children.
Then move forwards through the list until you find one of these children.
Discard everything in the list after this child
The child is now the last node in the list.
Repeat until the starting node is reached.
```


## Example code (Ruby)
```
require "pry"


@stations = {
  'Hornsby' => ['Epping', 'Chatswood', 'Brooklyn'],
  'Epping' => ['Hornsby', 'Chatswood', 'Strathfield', 'Carlingford'],
  'Chatswood' => ['Hornsby', 'Epping', 'Central'],
  'Strathfield' => ['Lidcombe', 'Epping', 'Central'],
  'Bankstown' => ['Sydneham', 'Liverpool','Lidcombe'],
  'Liverpool' => ['Blacktown', 'Bankstown','Lidcombe', 'Campbelltown'],
  'Sydneham' => ['Campbelltown', 'Bankstown','Central'],
  'Central' => ['Chatswood', 'Strathfield', 'Sydneham'],
  'Brooklyn' => ['Hornsby'],
  'Campbelltown' => ['Liverpool','Sydneham'],
  'Lidcombe' => ['Liverpool','Bankstown', 'Strathfield'],
  'Blacktown' => ['Liverpool', 'Penrith', 'Richmond'],
  'Richmond' => ['Blacktown'],
  'Penrith' => ['Blacktown'],
  'Carlingford' => ['Epping']
} # end of stations hash



def shortest_path start, destination, node_map

  # first - declare some variables for this function
  queue = [start] # queue is a list of stations to examine
  list = []       # stores the list of stations examined.
  trip = []       # array of the trip taken.

  while queue.length > 0
    ####################################
    ## This is the Breadth First part ##
    ####################################

    station_to_examine = queue.shift
    # remove queue[0] from [queue] and assign it to a variable.

    list << station_to_examine
    # add station_to_examine to [list] of examined stations
    # aka list.push(station_to_examine)

    children = @stations[station_to_examine]
    # get the children of the current station.

    queue = queue | children
    # add the children (not already in the queue) to the queue

    queue = queue - list
    # if we've already examined them, remove from queue

    if station_to_examine == destination
      break
    end
     # is this the destination? if yes, break out of this loop
     # leave this at the end of the loop, so queue list etc are acted upon.
     # this finishes the BFS part, now to reconstruct the [trip] from [list]

  end # end of while queue.length > 0 # we are finished.


  while list.length > 0
    #################################
    ## This is the part where we   ##
    ## construct the shortest path ##
    #################################

    current_stop = list.pop
    trip.push current_stop

    if current_stop == start
      break
    end

    stop_children = @stations[current_stop]

    # Now to find which of it's children appear first in [list]
    station_we_came_from = ( list & stop_children ).first
    index = list.index(station_we_came_from)

    #now remove all elements after station_we_came_from
    list = list.take( index + 1 )
    # aka - list.pop(list.length - (index + 1))


  end

  trip.reverse
end

p shortest_path "Carlingford", "Liverpool", @stations
```








# BFS

Solutions for finding the shortest path from A to B in a multi-node network.

https://gist.github.com/johnofsydney/c9f553a53383017e9844fa026d20250d
