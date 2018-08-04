require 'pry'


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

  queue = [start]
  list = []
  trip = []



  while queue.length > 0

    station_to_examine = queue.shift

    list << station_to_examine

    children = node_map[station_to_examine]

    queue = queue | children

    queue = queue - list

    if station_to_examine == destination
      break
    end


  # binding.pry
  end  # this is the end of the queue.length part


  while list.length > 0

    current_stop = list.pop
    trip.push current_stop

    if current_stop ==  start
      break
    end

    stop_children = node_map[current_stop]

    station_we_came_from =  (list & stop_children).first
    index = list.index(station_we_came_from)

    list = list.take(index + 1)

  end


  trip.reverse

end


p shortest_path "Strathfield", "Brooklyn", @stations
