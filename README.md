There's a heatwave in Australia at the moment. And this is the heatmap that is getting shown of Australia

``` r
knitr::include_graphics("bom-heat-map.png")
```

<img src="bom-heat-map.png" width="940" />

Which shows that things are really hot.

But it's also pretty darn ugly. And I wanted to see if I could make it better, using awesome packages like `viridis` to colour the heat appropriately.

This is me, documenting my struggle with shapefiles and geospatial data. Eventually this will get written up into a blog post. But I figured that it would be nice to put on github like this, so that others can contribute, if they like.

First, we load the packages.

``` r
library(rgdal)
```

    ## Loading required package: sp

    ## rgdal: version: 1.2-5, (SVN revision 648)
    ##  Geospatial Data Abstraction Library extensions to R successfully loaded
    ##  Loaded GDAL runtime: GDAL 2.1.2, released 2016/10/24
    ##  Path to GDAL shared files: 
    ##  Loaded PROJ.4 runtime: Rel. 4.9.1, 04 March 2015, [PJ_VERSION: 491]
    ##  Path to PROJ.4 shared files: (autodetected)
    ## WARNING: no proj_defs.dat in PROJ.4 shared files
    ##  Linking to sp version: 1.2-3

``` r
library(rgeos)
```

    ## rgeos version: 0.3-22, (SVN revision 544)
    ##  GEOS runtime version: 3.4.2-CAPI-1.8.2 r3921 
    ##  Linking to sp version: 1.2-4 
    ##  Polygon checking: TRUE

``` r
library(maptools)
```

    ## Checking rgeos availability: TRUE

``` r
library(ggplot2)
library(viridis)
```

Then we load the data, retrieved from [the bom site](http://www.bom.gov.au/jsp/awap/temp/index.jsp) - thanks to [Robbi Bishop Taylor](https://twitter.com/robbibt) for pointing out where to get it!

``` r
library(ozviridis)
data("oz_heat")

class(oz_heat)
```

    ## [1] "SpatialGridDataFrame"
    ## attr(,"package")
    ## [1] "sp"

``` r
# oz_heat <- readGDAL("2017-02-11-oz-heat.grid") # reads in the whole raster
```

Quick methods for plotting
==========================

OK, so I can get a pretty basic plot with base `image`.

``` r
image(oz_heat) # does a plot
```

![](README_files/figure-markdown_github/unnamed-chunk-2-1.png)

But the colour scale isn't great.

With the `viridis` package I can make them look pretty.

``` r
image(oz_heat,
      col = viridis(15,
                    option = "magma")
      )
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
image(oz_heat,
      col = viridis(15,
                    option = "plasma")
      )
```

![](README_files/figure-markdown_github/unnamed-chunk-3-2.png)

``` r
image(oz_heat,
      col = viridis(15,
                    option = "viridis")
      )
```

![](README_files/figure-markdown_github/unnamed-chunk-3-3.png)

There's also the default `spplot` from `sp`

``` r
spplot(oz_heat,
       col = viridis(15,
                     option = "plasma"))
```

![](README_files/figure-markdown_github/unnamed-chunk-4-1.png)

So, the goal from here is to:

-   Add the shapefile of Australia
-   use `sf`
-   Plot using ggplot
-   add better legends etc to make it look more similar to the BoM image

``` r
knitr::include_graphics("bom-heat-map.png")
```

<img src="bom-heat-map.png" width="940" />
