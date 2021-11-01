library(osrm)
library(leaflet)
# - osrmTable Get travel time matrices between points.
# - osrmRoute Get the shortest path between two points.
# - osrmTrip Get the travel geometry between multiple unordered points.
# - osrmIsochrone Get polygons of isochrones.

options(osrm.server = "http://127.0.0.1:5000/")
locations = data.frame(comm_id = c("A", "B"),
                       lon = c(13.38886, 13.385983),
                       lat = c(52.517037, 52.496891)
                       )
table <- osrmTable(loc = locations, 
                   measure = "distance"
                   )
table
# Haversine  (distance) https://en.wikipedia.org/wiki/Haversine_formula
library(geodist)
geodist (locations)


# Work out trip (TSP), shortest path
trip <- osrmTrip(locations)
trip

# Get the spatial lines dataframe 
trip_sp <- trip[[1]]$trip

# PLOT WITH LEAFLET
leaflet(data = trip_sp) %>% 
  addTiles() %>% 
  addMarkers(lng = locations$lon, lat = locations$lat, popup = locations$comm_id) %>%
  addPolylines()

# isochromes

