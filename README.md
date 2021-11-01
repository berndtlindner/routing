# routing
Basics to find routes, etc on OSRM and google maps API. With the help of packages/functions in R and python, etc.

- [routing](#routing)
- [Google maps](#google-maps)
  - [Example](#example)
- [OSRM](#osrm)
  - [Example](#example-1)
  - [Geocoding](#geocoding)
  - [Vehicle routing](#vehicle-routing)
  - [Setup osrm server](#setup-osrm-server)
- [R](#r)
  - [OSRM](#osrm-1)
- [Python](#python)
  - [Google maps](#google-maps-1)
  - [OSRM](#osrm-2)
- [References](#references)

# Google maps
https://www.google.com/maps  
https://developers.google.com/maps   
https://github.com/googlemaps/  
https://github.com/googlemaps/google-maps-services-python


## Example
https://www.google.com/maps/dir/52.517037,13.38886/52.496891,13.385983


# OSRM
[Open Source Routing Machine](http://project-osrm.org/)

## Example
https://map.project-osrm.org/?loc=52.517037,13.38886&loc=52.496891,13.385983

## Geocoding

https://geocoder.readthedocs.io/providers/OpenStreetMap.html

## Vehicle routing
http://vroom-project.org/

## Setup osrm server

0.  Get the image
```
docker pull osrm/osrm-backend
```
1. Make sure you have the correct [http://download.geofabrik.de/](Geofabrik) map to run on.
Place this where your docker container can access it, I prefer to just put it in `/tmp`.   
```
wget http://download.geofabrik.de/europe/germany/berlin-latest.osm.pbf --directory-prefix=/tmp`
```
2. Start the container
```
cd /tmp
```  
```
docker run -t -v "${PWD}:/tmp" osrm/osrm-backend osrm-extract -p /opt/car.lua /tmp/berlin-latest.osm.pbf
```

```
docker run -t -v "${PWD}:/tmp" osrm/osrm-backend osrm-partition /tmp/berlin-latest.osrm
```
```
docker run -t -v "${PWD}:/tmp" osrm/osrm-backend osrm-customize /tmp/berlin-latest.osrm
```
```
docker run -t -i -p 5000:5000 -v "${PWD}:/tmp" osrm/osrm-backend osrm-routed --algorithm mld /tmp/berlin-latest.osrm
```

We can swap the /opt/car.lua for other profiles, and other settings, for more see [https://github.com/Project-OSRM/osrm-backend#using-docker](https://github.com/Project-OSRM/osrm-backend#using-docker)

3. Make a request, for example

```
curl "http://127.0.0.1:5000/route/v1/driving/13.388860,52.517037;13.385983,52.496891?steps=true"
```

4. (Optional) Front-end  
Optionally start a user-friendly frontend on port 9966, and open it up in your browser

```
docker run -p 9966:9966 osrm/osrm-frontend
xdg-open 'http://127.0.0.1:9966'
```

# R
[routing.R](routing.R)

## OSRM
https://www.r-bloggers.com/2017/09/building-a-local-osrm-instance/   
https://rpubs.com/mbeckett/running-in-circles 


# Python 
[routing.ipynb](routing.ipynb)

## Google maps

https://github.com/googlemaps/google-maps-services-python 
https://thedatafrog.com/en/articles/show-data-google-map-python/ 
https://www.codeforests.com/2021/01/23/plot-route-on-google-maps/ 

## OSRM
https://pypi.org/project/osrm-py/  
https://github.com/ustroetz/python-osrm 
https://www.thinkdatascience.com/post/2020-03-03-osrm/osrm/  
https://medium.com/swlh/route-optimization-leveraging-the-power-of-google-cloud-and-osrm-to-analyze-delivery-routes-in-e4f73ec7dad1  


# References
https://github.com/Project-OSRM/osrm-backend#using-docker  
https://gist.github.com/AlexandraKapp/e0eee2beacc93e765113aff43ec77789  