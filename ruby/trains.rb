require "pry"


@sydney = {
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
# 

@london = {
  'Paddington' => ['Baker Street', 'Notting Hill Gate'],
  'Baker Street' => ['Paddington', 'Bond Street', 'Kings Cross St Pancras'],
  'Warren Street' => ['Oxford Circus', 'Tottenham Court Road'],
  'Kings Cross St Pancras' => ['Baker Street', 'Moorgate', 'Holborn'],
  'Moorgate' => ['Kings Cross St Pancras', 'Bank'],
  'Notting Hill Gate' => ['Paddington', 'South Kensington', 'Bond Street'],
  'Bond Street' => ['Baker Street', 'Notting Hill Gate', 'Green Park', 'Oxford Circus'],
  'Oxford Circus' => ['Bond Street', 'Baker Street', 'Warren Street', 'Tottenham Court Road', 'Piccadilly Circus', 'Green Park'],
  'Tottenham Court Road' => ['Oxford Circus', 'Warren Street', 'Holborn', 'Leicester Square'],
  'Holborn' => ['Tottenham Court Road', 'Kings Cross St Pancras', 'Bank', 'Leicester Square'],
  'Bank' => ['Holborn', 'Moorgate', 'Embankment'],
  'South Kensington' => ['Notting Hill Gate', 'Green Park', 'Victoria'],
  'Victoria' => ['South Kensington', 'Green Park', 'Westminster'],
  'Westminster' => ['Victoria', 'Green Park', 'Embankment'],
  'Embankment' => ['Westminster', 'Charing Cross', 'Bank'],
  'Green Park' => ['Bond Street', 'Oxford Circus', 'Piccadilly Circus', 'Westminster', 'Victoria', 'South Kensington'],
  'Piccadilly Circus' => ['Oxford Circus', 'Leicester Square', 'Charing Cross', 'Green Park'],
  'Leicester Square' => ['Tottenham Court Road', 'Holborn', 'Charing Cross', 'Piccadilly Circus'],
  'Charing Cross' => ['Piccadilly Circus', 'Leicester Square', 'Embankment']

}


@musicians = {
  'David Bowie' => ['Freddie Mercury', 'Mick Jagger', 'Lou Reed', 'Iggy Pop', 'Neil Tennant', 'Trent Reznor', 'David Gilmour'],
  'Johnny Cash' => ['Bob Dylan', 'Trent Reznor', 'Nick Cave', 'The Edge'],
  'Paul McCartney' => ['George Harrison', 'Eric Clapton', 'Michael Jackson', 'Kanye West'],
  'George Harrison' => ['Paul McCartney', 'Eric Clapton', 'Roy Orbison', 'Bob Dylan'],
  'Johnny Marr' => ['Noel Gallagher', 'Morrisey', 'Bernard Sumner', 'Neil Tennant'],
  'Kanye West' => ['Elton John', 'Paul McCartney', 'Beyonce'],
  'Eric Clapton' => ['George Harrison', 'Paul McCartney', 'Elton John'],
  'Elton John' => ['Kanye West', 'Eric Clapton'],
  'Beyonce' => ['Jack White', 'Lady Gaga', 'Kanye West'],
  'Lady Gaga' => ['Beyonce', 'Tony Bennet'],
  'Roy Orbison' => ['George Harrison'],
  'Noel Gallagher' => ['Johnny Marr'],
  'Morrisey' => ['Johnny Marr'],
  'Bernard Sumner' => ['Johnny Marr', 'Neil Tennant', 'Ian Curtis'],
  'Neil Tennant' => ['David Bowie', 'Johnny Marr', 'Bernard Sumner'],
  'Dusty Springfield' => ['John Paul Jones'],
  'John Paul Jones' => ['Dusty Springfield', 'Jimmy Page'],
  'Michael Jackson' => ['Paul McCartney', 'Eddie Van Halen'],
  'Eddie Van Halen' => ['Ozzy Osbourne', 'Michael Jackson'],
  'Ozzy Osbourne' => ['Eddie Van Halen'],
  'Bob Dylan' => ['Johnny Cash', 'George Harrison'],
  'Trent Reznor' => ['David Bowie', 'Johnny Cash'],
  'Nick Cave' => ['Kylie Minogue', 'Johnny Cash'],
  'The Edge' => ['Johnny Cash', 'Bono'],
  'Bono' => ['The Edge'],
  'Freddie Mercury' => ['David Bowie'],
  'Mick Jagger' => ['David Bowie'],
  'Lou Reed' => ['James Hetfield', 'David Bowie'],
  'James Hetfield' => ['Lou Reed'],
  'Iggy Pop' => ['David Bowie'],
  'David Gilmour' => ['David Bowie'],
  'Steve Tyler' => ['DMC'],
  'DMC' => ['Steve Tyler'],
  'Tony Bennet' => ['Stevie Wonder', 'Lady Gaga'],
  'Stevie Wonder' => ['Tony Bennet'],
  'Jack White' => ['Beyonce', 'Jimmy Page'],
  'Jimmy Page' => ['Jack White', 'John Paul Jones'],
  'Kylie Minogue' => ['Nick Cave'],
  'Ian Curtis' => ['Bernard Sumner']
}

def shortest_path start, destination, node_map

  # first - declare some variables for this function
  queue = [start] # queue is a list of stations to examine
  list = []       # stores the list of stations examined.
  trip = []       # array of the trip taken - we won't use this until shortest pat

  while queue.length > 0
    ####################################
    ## This is the Breadth First part ##
    ####################################

    station_to_examine = queue.shift
    # remove queue[0] from [queue] and assign it to a variable.

    list << station_to_examine
    # add station_to_examine to [list] of examined stations
    # aka list.push(station_to_examine)

    children = node_map[station_to_examine]
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

    stop_children = node_map[current_stop]

    # Now to find which of it's children appear first in [list]
    station_we_came_from = ( list & stop_children ).first
    index = list.index(station_we_came_from)

    #now remove all elements after station_we_came_from
    list = list.take( index + 1 )
    # aka - list.pop(list.length - (index + 1))


  end

  trip.reverse
end

p shortest_path "Carlingford", "Liverpool", @sydney
p shortest_path "Bank", "South Kensington", @london
p shortest_path "Green Park", "Moorgate", @london
p shortest_path "Lady Gaga", "James Hetfield", @musicians
p shortest_path "Lady Gaga", "Steve Tyler", @musicians
