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
  trip = []       # array of the trip taken - we won't use this until shortest path

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
