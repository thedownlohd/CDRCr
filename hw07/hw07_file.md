---
title: "Kendall_Loh_hw07"
author: "Kendall Loh"
date: "11/7/2018"
output: 
  html_document:
    keep_md: true
---



## 1. Define the base URL
### In the documentation, find the API Endpoint for csv (Hint: if there is a json at the end, replace json with csv).


```r
endpoint <- "http://data.lacity.org/resource/7fvc-faax.csv"
```




## 2. Send a simple GET request
### Using httr, send a simple GET request to the base URL. Check for the status and structure of the response (print only the first level in your ouput using the option max.level).



```r
library(httr)

req_result <- httr::GET("http://data.lacity.org/resource/7fvc-faax.csv")
# can also use query = list('$limit' = 10)
print(str(req_result, max.level=1))
```

```
## List of 10
##  $ url        : chr "http://data.lacity.org/resource/7fvc-faax.csv"
##  $ status_code: int 200
##  $ headers    :List of 19
##   ..- attr(*, "class")= chr [1:2] "insensitive" "list"
##  $ all_headers:List of 1
##  $ cookies    :'data.frame':	0 obs. of  7 variables:
##  $ content    : raw [1:333364] 22 3a 40 63 ...
##  $ date       : POSIXct[1:1], format: "2018-11-10 18:15:41"
##  $ times      : Named num [1:6] 0 0.094 0.125 0.125 0.219 0.328
##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
##  $ request    :List of 7
##   ..- attr(*, "class")= chr "request"
##  $ handle     :Class 'curl_handle' <externalptr> 
##  - attr(*, "class")= chr "response"
## NULL
```





## 3. Get the content of the response
### Retrieve the content of the response. What are the dimensions of the data frame? Tabulate the areas of the observations included.


```r
get_result <- GET("http://data.lacity.org/resource/7fvc-faax.csv")
content1 <- content(req_result)
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   `:@computed_region_2dna_qi2s` = col_integer(),
##   `:@computed_region_k96s_3jcv` = col_integer(),
##   `:@computed_region_kqwf_mjcx` = col_integer(),
##   `:@computed_region_qz3q_ghft` = col_integer(),
##   `:@computed_region_tatf_ua23` = col_integer(),
##   `:@computed_region_ur2y_g4cx` = col_integer(),
##   crm_cd = col_integer(),
##   crm_cd_1 = col_integer(),
##   crm_cd_2 = col_integer(),
##   crm_cd_3 = col_integer(),
##   crm_cd_4 = col_integer(),
##   date_occ = col_datetime(format = ""),
##   date_rptd = col_datetime(format = ""),
##   dr_no = col_integer(),
##   premis_cd = col_integer(),
##   vict_age = col_integer(),
##   weapon_used_cd = col_integer()
## )
```

```
## See spec(...) for full column specifications.
```

```r
print(count(content1$area_name))
```

```
##              x freq
## 1  77th Street   50
## 2      Central   59
## 3   Devonshire   33
## 4     Foothill   37
## 5       Harbor   16
## 6   Hollenbeck   35
## 7    Hollywood   75
## 8      Mission   75
## 9  N Hollywood   52
## 10      Newton   39
## 11   Northeast   29
## 12     Olympic   75
## 13     Pacific   25
## 14     Rampart   34
## 15   Southeast   59
## 16   Southwest   66
## 17     Topanga   81
## 18    Van Nuys   28
## 19     West LA   33
## 20 West Valley   28
## 21    Wilshire   71
```

There are 36 variables and 1000 observations in the dataframe, as shown above. 





## 4. Get your access token
### As you have noticed, our initial request yieled only a small part of the data. For full access (actually the API seems not to care much, but for exercise’s sake let’s do it), you will need an API key to access the data. Sign up here https://data.lacity.org/profile/app_tokens and get your token.


### To keep your key safe, it is always better not to add it to your code. Place your token in the R environment file (as shown in class). Add the following lines (with your access info) to the `.Renviron` file. (Note: if you have trouble, take a look at this [more extended discussion of the `.Renviron` file](https://csgillespie.github.io/efficientR/3-3-r-startup.html#renviron).)

### App Token for https://data.lacity.org
### LACRIME_APP_TOKEN = ...
### LACRIME_SECRET_TOKEN =  ...

### Now, resend your query with the fields: `"$limit" = "10000"` and `"$$app_token" =  Sys.getenv("LACRIME_APP_TOKEN")` as query parameteurs and show the status of the server response.



```r
parameter_response <- httr::GET("http://data.lacity.org/resource/7fvc-faax.csv", query = list('$limit' = '10000', '$$app_token' = Sys.getenv("LACRIME_APP_TOKEN")))
#Making sure my token works Sys.getenv("LACRIME_APP_TOKEN")

#status code is 200!
parameter_response
```

```
## Response [http://data.lacity.org/resource/7fvc-faax.csv?%24limit=10000&%24%24app_token=jp4mCRThBt3EZXQBnBsm7xeJA]
##   Date: 2018-11-10 18:15
##   Status: 200
##   Content-Type: text/csv; charset=UTF-8
##   Size: 3.17 MB
## "area_id","area_name","crm_cd","crm_cd_1","crm_cd_2","crm_cd_3","crm_cd_...
## "01","Central","740","740",,,,"VANDALISM - FELONY ($400 & OVER, ALL CHUR...
## "01","Central","888","888",,,,"TRESPASSING","ALAMEDA                    ...
## "20","Olympic","740","740",,,,"VANDALISM - FELONY ($400 & OVER, ALL CHUR...
## "01","Central","330","330",,,,"BURGLARY FROM VEHICLE",,"2017-11-01T00:00...
## "01","Central","330","330",,,,"BURGLARY FROM VEHICLE","SAN PEDRO        ...
## "01","Central","745","745",,,,"VANDALISM - MISDEAMEANOR ($399 OR UNDER)"...
## "21","Topanga","330","330","998",,,"BURGLARY FROM VEHICLE",,"2018-07-03T...
## "01","Central","510","510",,,,"VEHICLE - STOLEN",,"2017-11-01T00:00:00.0...
## "01","Central","888","888",,,,"TRESPASSING",,"2017-11-02T00:00:00.000","...
## ...
```

```r
parameter_response$status_code
```

```
## [1] 200
```

```r
content2 <- content(parameter_response)
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   crm_cd = col_integer(),
##   crm_cd_1 = col_integer(),
##   crm_cd_2 = col_integer(),
##   crm_cd_3 = col_integer(),
##   crm_cd_4 = col_integer(),
##   date_occ = col_datetime(format = ""),
##   date_rptd = col_datetime(format = ""),
##   dr_no = col_integer(),
##   premis_cd = col_integer(),
##   vict_age = col_integer(),
##   weapon_used_cd = col_integer()
## )
```

```
## See spec(...) for full column specifications.
```




## 5. Limiting your query
### Choose at least two more query field parameters from the API description [the blueish list on the bottom of the page], pass them to the query parameter list, and run the query (providing the server status again). Describe briefly in words what your query is selecting.

So here, I ran a second query using the `vict_age` and `time_occ` parameters. `vict_age` represents the age of the victim of the crime, and the `time_occ` paramter represents the time at which the crime occurred. Based on this query, there were 676 crimes committed at time = 0100 and whose victim age was 22. Additional paramters are limit of 10000 observations, which the other queries limit anyway, and the apptoken data from my environment.


```r
parameter_response2 <- httr::GET("http://data.lacity.org/resource/7fvc-faax.csv", query = list('$limit' = '10000', 'vict_age' = '22', 'time_occ' = '0100', '$$app_token' = Sys.getenv("LACRIME_APP_TOKEN")))

#'$limit' = 10000, 
parameter_response2
```

```
## Response [http://data.lacity.org/resource/7fvc-faax.csv?%24limit=10000&vict_age=22&time_occ=0100&%24%24app_token=jp4mCRThBt3EZXQBnBsm7xeJA]
##   Date: 2018-11-10 18:15
##   Status: 200
##   Content-Type: text/csv; charset=UTF-8
##   Size: 216 kB
## "area_id","area_name","crm_cd","crm_cd_1","crm_cd_2","crm_cd_3","crm_cd_...
## "07","Wilshire","230","230","998",,,"ASSAULT WITH DEADLY WEAPON, AGGRAVA...
## "10","West Valley","210","210",,,,"ROBBERY","CALDUS                     ...
## "13","Newton","310","310","998",,,"BURGLARY",,"2018-06-07T00:00:00.000",...
## "03","Southwest","761","761",,,,"BRANDISH WEAPON",,"2018-06-03T00:00:00....
## "15","N Hollywood","230","230",,,,"ASSAULT WITH DEADLY WEAPON, AGGRAVATE...
## "15","N Hollywood","230","230",,,,"ASSAULT WITH DEADLY WEAPON, AGGRAVATE...
## "15","N Hollywood","230","230",,,,"ASSAULT WITH DEADLY WEAPON, AGGRAVATE...
## "03","Southwest","236","236",,,,"INTIMATE PARTNER - AGGRAVATED ASSAULT",...
## "03","Southwest","624","624",,,,"BATTERY - SIMPLE ASSAULT",,"2017-12-11T...
## ...
```

```r
parameter_response2$status_code
```

```
## [1] 200
```

```r
content3 <- content(parameter_response2)
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   crm_cd = col_integer(),
##   crm_cd_1 = col_integer(),
##   crm_cd_2 = col_integer(),
##   date_occ = col_datetime(format = ""),
##   date_rptd = col_datetime(format = ""),
##   dr_no = col_integer(),
##   premis_cd = col_integer(),
##   vict_age = col_integer(),
##   weapon_used_cd = col_integer()
## )
```

```
## See spec(...) for full column specifications.
```




## 6. Locations
### The dataset already provides us with good geographic information on latitude and longitude and some address information (for privacy reasons, the locations are approximate).

### Let’s try to use the Google Maps reverse geocode API to find the addresses for some locations.

### The query we will need to look like this:

"https://maps.googleapis.com/maps/api/geocode/json?latlng=-37.866963,144.980615&key=YOUR_API_KEY"

### The documentation of the API is here.

### Write a loop to find the addresses for 50 entries in your dataset based on their latitude and longitude. The object you get back is a bit verbose – aim for the formatted_address part. In the loop, add a status check (using an if statement) that will warn us if something goes awry. Lastly, add a Sys.sleep pause of 0.1 seconds after each URL retrieval to make sure we use the Google Maps API responsibly.



```r
#Pulling out the latitude/longitude numbers
# I limited here because my computer couldn't handle working with the full set of data
latlong = content2$location_1
data <- latlong[1:50]
data_plain <- regmatches(data, gregexpr("(?<=\\().*?(?=\\))", data, perl=T))
data_plain <- t(data_plain)
data_plain <- as.data.frame(data_plain)
data_plain <- as.data.frame(t(data_plain))

new_latlong <- data_plain %>% separate(V1, c('Latitude', 'Longitude'), sep=" ")

DF = new_latlong
DF$Coordinates = paste(DF$Longitude, DF$Latitude, sep = ",")

a <- 1
for (i in DF$Coordinates[1:50]) {
  response <- GET("https://maps.googleapis.com/maps/api/geocode/json", query = list("latlng" = i, "key" = Sys.getenv("GMAPS_API_TOKEN")))
  print(response$status_code)
  if(http_error(response)){
    warning("GET REQUEST ERROR")
  } else {
    address <- print(content(response)$results[[1]]$formatted_address)
    DF$Pulled_address[a] <- address
    }
  Sys.sleep(0.1)
  a <- a + 1
}
```

```
## [1] 200
## [1] "144 W 18th St, Los Angeles, CA 90015, USA"
## [1] 200
## [1] "935 N Vignes St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "861 Fedora St, Los Angeles, CA 90005, USA"
## [1] 200
## [1] "53 S Santa Fe Ave, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "452 E 3rd St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "528 San Julian St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "20557 Sherman Way, Winnetka, CA 91306, USA"
## [1] 200
## [1] "550 N Figueroa St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "300 E 5th St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "712 S Figueroa St, Los Angeles, CA 90017, USA"
## [1] 200
## [1] "501 S Grand Ave, Los Angeles, CA 90071, USA"
## [1] 200
## [1] "238 S Westmoreland Ave, Los Angeles, CA 90004, USA"
## [1] 200
## [1] "13733 Oscar St, Sylmar, CA 91342, USA"
## [1] 200
## [1] "617A W 7th St, Los Angeles, CA 90017, USA"
## [1] 200
## [1] "Wilshire EB & Grand NS, Los Angeles, CA 90017, USA"
## [1] 200
## [1] "6th / Wall, Los Angeles, CA 90014, USA"
## [1] 200
## [1] "814 S Francisco St, Los Angeles, CA 90017, USA"
## [1] 200
## [1] "206 E 14th St, Los Angeles, CA 90015, USA"
## [1] 200
## [1] "1200 S Hope St, Los Angeles, CA 90015, USA"
## [1] 200
## [1] "990 W 8th St, Los Angeles, CA 90017, USA"
## [1] 200
## [1] "629 San Julian St, Los Angeles, CA 90014, USA"
## [1] 200
## [1] "1200 S Hope St, Los Angeles, CA 90015, USA"
## [1] 200
## [1] "300 E 5th St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "963 W 2nd St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "425 S Main St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "557-599 S Hope St, Los Angeles, CA 90071, USA"
## [1] 200
## [1] "5019 E 18th St, Los Angeles, CA 90015, USA"
## [1] 200
## [1] "320 W 4th St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "Lucky Strike Bowling - Los Angeles, 800 W Olympic Blvd, Los Angeles, CA 90015, USA"
## [1] 200
## [1] "529 Maple Ave, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "814 S Francisco St, Los Angeles, CA 90017, USA"
## [1] 200
## [1] "218 N Hope St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "645 W 4th St, Los Angeles, CA 90071, USA"
## [1] 200
## [1] "501 E 4th St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "231 Winston St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "400 Alameda St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "501 S Grand Ave, Los Angeles, CA 90071, USA"
## [1] 200
## [1] "501 S Grand Ave, Los Angeles, CA 90071, USA"
## [1] 200
## [1] "701 N Spring St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "679 E 5th St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "506 E 1st St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "323 E 5th St, Los Angeles, CA 90013, USA"
## [1] 200
## [1] "8 W 8th St, Los Angeles, CA 90014, USA"
## [1] 200
## [1] "810 N Alameda St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "United States, California, Los Angeles, 1100 South San Pedro Street D-4 & D-5"
## [1] 200
## [1] "766 W College St, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "College St. & Figueroa Terrace, Los Angeles, CA 90012, USA"
## [1] 200
## [1] "4601 Del Moreno Dr, Woodland Hills, CA 91364, USA"
## [1] 200
## [1] "20308 Hart St, Winnetka, CA 91306, USA"
## [1] 200
## [1] "320 W 4th St, Los Angeles, CA 90013, USA"
```

```r
View(DF)
```


