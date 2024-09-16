# MapWarper and QGIS Ground Control Points

[MapWarper API documentation](https://github.com/timwaters/mapwarper/blob/master/README_API.md)

Tested using Macrepo 73134, MapExplorer map #793 


## MapWarper GCP format:
```
x,y,lon,lat
2631.6425,3204.6875,-79.8286559286,43.2479535564
2482.945,3671.29,-79.8298361006,43.2449213248
3610.995,4102.0,-79.8196222487,43.242482926
4072.47,2738.085,-79.8160602751,43.2513607292
```

## QGIS GCP format:
```
mapX,mapY,sourceX,sourceY
-79.8286559286,43.2479535564,2631.6425,-3204.6875
-79.8298361006,43.2449213248, 2482.945,-3671.29
-79.8196222487,43.242482926,3610.995,-4102.0
-79.8160602751,43.2513607292,4072.47,-2738.085
```

## Notes from CH:
•	The source or image Y field differs between the two programs (+ in MapWarper and – in QGIS)
•	The field order appears to matter when moving from MapWarper to QGIS



