---
title: "QMSS G5072 Homework 8"
author: Kendall Loh
date: 2018-11-22
always_allow_html: yes
output: 
  html_document:
    keep_md: true
---

Writing a simple API client
============================

# Task

The task is to use the `httr` package (do not use possibly existing specific R packages for the API) to:  

  - interact with the API  
  - create a dataset with multiple records by requesting data from the API using the `httr` package  
  - write a simple API client, i.e. a function that would make downloading/interacting with the API simple for a R user who does not know `httr` 

## 1. Choose an API

### a) Choose an API and briefly describe the type of data you can obtain from it. Note: Please do not use any of the APIs we covered in lecture (e.g. Twitter, NYTimes, Enigma, Zillow etc.).

The API I chose to work with is 'An API of Ice and Fire', which is an API containing data related to the hit book and TV series Game of Thrones.

The API contains data tables which show lists of books, characters, and houses, and how they are related, as well as information about the characters and houses like name, date of birth and date of death, and how each character and house is related to one another.

### b) Provide a link to the API documentation and  

link to API: "https://www.anapioficeandfire.com/Documentation#authentication"

### c) the base URL of the API you intend to use.
base <- "https://www.anapioficeandfire.com/api/"

## 2. Authentication

### a) Briefly explain how the API authenticates the user. 
### b) Apply for an API key if necessary and provide the information (with relevant URL) how that can be done.

As far as authentication goes, An API of Ice And Fire is considered an 'open' API. This means that one does not need an API key or any other type of authentication to query the API for data.


## 3. Send a Simple GET request

### a) Execute a simple GET request to obtain a small amount of data from the API. Describe a few query parameters and add them to the query. If you have a choice of the output the API returns (e.g. XML or JSON), I suggest to choose JSON because it easier to work with. Your output here should include the code for the `GET` request, including the query parameters.  
### b) Check the status of the request (using `http_status`).  
### c) Check the type of the response (e.g. XML, JSON, csv using `http_type`).


```r
# Getting a 'small' amount of data, or the first page of character data that is returned from the API.
library(httr)
library(plyr)
url <- "https://www.anapioficeandfire.com/api/"
API <- GET(url)
# The query params I chose to use are page = 1 and size of 50
query_params = list("characters?page=1&pageSize=50")
API1 <- paste(url,query_params,sep="")
API1
```

```
## [1] "https://www.anapioficeandfire.com/api/characters?page=1&pageSize=50"
```

```r
g1t <- GET(API1)
g1t
```

```
## Response [https://www.anapioficeandfire.com/api/characters?page=1&pageSize=50]
##   Date: 2018-11-22 18:33
##   Status: 200
##   Content-Type: application/json; charset=utf-8
##   Size: 25.8 kB
```

```r
# Printing http_status of get request
print(http_status(g1t))
```

```
## $category
## [1] "Success"
## 
## $reason
## [1] "OK"
## 
## $message
## [1] "Success: (200) OK"
```

```r
# Printing http_type of get request
print(http_type(g1t))
```

```
## [1] "application/json"
```



## 4. Parse the response and Create a dataset

### a) Take the response returned by the API and turn it into a useful R object (e.g. a list, vector, or data frame). Show the code how this is done.  


```r
library(jsonlite)
#taking the content from the get request above
useful <- content(g1t, as = "text")
df_object <- fromJSON(useful)
head(df_object)
```

```
##                                                  url   name gender
## 1 https://www.anapioficeandfire.com/api/characters/1        Female
## 2 https://www.anapioficeandfire.com/api/characters/2 Walder   Male
## 3 https://www.anapioficeandfire.com/api/characters/3          Male
## 4 https://www.anapioficeandfire.com/api/characters/4        Female
## 5 https://www.anapioficeandfire.com/api/characters/5          Male
## 6 https://www.anapioficeandfire.com/api/characters/6        Female
##    culture born died titles                  aliases father mother spouse
## 1 Braavosi                  The Daughter of the Dusk                     
## 2                                              Hodor                     
## 3                                            Lamprey                     
## 4 Braavosi                         The Merling Queen                     
## 5                                     Old Crackbones                     
## 6 Braavosi                               The Poetess                     
##                                        allegiances
## 1                                                 
## 2 https://www.anapioficeandfire.com/api/houses/362
## 3  https://www.anapioficeandfire.com/api/houses/15
## 4                                                 
## 5                                                 
## 6                                                 
##                                                                                                                                                                                                                                       books
## 1                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/5
## 2 https://www.anapioficeandfire.com/api/books/1, https://www.anapioficeandfire.com/api/books/2, https://www.anapioficeandfire.com/api/books/3, https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 3                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/3
## 4                                                                                                                                              https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 5                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/5
## 6                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/5
##   povBooks                                         tvSeries       playedBy
## 1     NULL                                                                
## 2     NULL Season 1, Season 2, Season 3, Season 4, Season 6 Kristian Nairn
## 3     NULL                                                                
## 4     NULL                                                                
## 5     NULL                                                                
## 6     NULL
```

### b) Using the API, create a dataset (in data frame format) for multiple records. I'd say a sample size greater than 100 is sufficient for the example but feel free to get more data if you feel ambitious and the API allows you to do that fairly easily. The dataset can include only a small subset of the returned data. Just choose some interesting features. There is no need to be inclusive here.

```r
url1 <- "https://www.anapioficeandfire.com/api/"
API1 <- GET(url1)
query1 = "characters?page=2&pageSize=50"
API2 <- paste(url1,query1,sep="")


g2t <- GET(API2)


useful2 <- content(g2t, as = "text")
library(jsonlite)
df1_object <- fromJSON(useful2, simplifyDataFrame = TRUE)

#stacking the two dataframes, for a total of 100 character observations
total <- rbind(df_object, df1_object)

## This table is 100 rows by 16 columns
dim(total)
```

```
## [1] 100  16
```

```r
print(head(total))
```

```
##                                                  url   name gender
## 1 https://www.anapioficeandfire.com/api/characters/1        Female
## 2 https://www.anapioficeandfire.com/api/characters/2 Walder   Male
## 3 https://www.anapioficeandfire.com/api/characters/3          Male
## 4 https://www.anapioficeandfire.com/api/characters/4        Female
## 5 https://www.anapioficeandfire.com/api/characters/5          Male
## 6 https://www.anapioficeandfire.com/api/characters/6        Female
##    culture born died titles                  aliases father mother spouse
## 1 Braavosi                  The Daughter of the Dusk                     
## 2                                              Hodor                     
## 3                                            Lamprey                     
## 4 Braavosi                         The Merling Queen                     
## 5                                     Old Crackbones                     
## 6 Braavosi                               The Poetess                     
##                                        allegiances
## 1                                                 
## 2 https://www.anapioficeandfire.com/api/houses/362
## 3  https://www.anapioficeandfire.com/api/houses/15
## 4                                                 
## 5                                                 
## 6                                                 
##                                                                                                                                                                                                                                       books
## 1                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/5
## 2 https://www.anapioficeandfire.com/api/books/1, https://www.anapioficeandfire.com/api/books/2, https://www.anapioficeandfire.com/api/books/3, https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 3                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/3
## 4                                                                                                                                              https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 5                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/5
## 6                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/5
##   povBooks                                         tvSeries       playedBy
## 1     NULL                                                                
## 2     NULL Season 1, Season 2, Season 3, Season 4, Season 6 Kristian Nairn
## 3     NULL                                                                
## 4     NULL                                                                
## 5     NULL                                                                
## 6     NULL
```

### c) Provide some summary statistics of the data. Include the data frame in a .RDS file (using `saveRDS`) called `data.rds` with your submission for the grader.


```r
sum1 <- count(total$gender)
sum2 <- count(total$culture)
summary <- rbind.data.frame(sum1, sum2)
#printing summary data, just counts of the genders and cultures of the included data.
print(summary)
```

```
##             x freq
## 1      Female   32
## 2        Male   68
## 3               70
## 4       Andal    1
## 5    Braavosi    5
## 6    Ironborn    3
## 7    Northmen    4
## 8  Stormlands    2
## 9    Valyrian   14
## 10   Westeros    1
```

```r
#I created two RDS files, as I wasn't sure which was supposed to be included in the file. 

saveRDS(total, "data.rds")
saveRDS(summary, "summarydata.rds")
```

## 5. API Client

### Lastly, let's try to wrap the code from the previous sections into a simple API client function. For example, in the `ZillowR` package, the command ### `GetSearchResults()` can be called with the following command

### GetSearchResults(address = '2114 Bigelow Ave', citystatezip = 'Seattle, WA')

### For your API function, try to create a simple function that does the following things:

### - allows to user to specify some smallish set of query parameters (from Q.3a)  
### - run a GET request with these parameters  
### - check the status of the request the server returns and inform the user of any errors (from Q.3b)  
### - parse the response and return a R object to the user of the function. You can choose whether returning a list (from Q.4a) or a data frame (from ### Q.4b) is best.
 
### Note: There is no need to make this into an R package here. A simple function is sufficient.



```r
# This function allows the user to choose which page they want to print from the api via an "x" value which they choose.
AAOIAF_api <- function(x) {
  url3 <- modify_url("http://www.anapioficeandfire.com/api/characters", path = paste("/api/characters?page=", x, sep = ""))
  step_1 <- GET(url3)
  step_2 <- content(step_1, as = "text")
  object <- fromJSON(step_2)
  print(object)
  saveRDS(object,"function.rds")
  print(http_status(step_1))
  print(http_error(step_1))
}
  AAOIAF_api(3)
```

```
##                                                    url             name
## 1  https://www.anapioficeandfire.com/api/characters/21        Nysterica
## 2  https://www.anapioficeandfire.com/api/characters/22          Ollidor
## 3  https://www.anapioficeandfire.com/api/characters/23           Osmynd
## 4  https://www.anapioficeandfire.com/api/characters/24          Raynard
## 5  https://www.anapioficeandfire.com/api/characters/25          Scolera
## 6  https://www.anapioficeandfire.com/api/characters/26          Torbert
## 7  https://www.anapioficeandfire.com/api/characters/27  Tywin Lannister
## 8  https://www.anapioficeandfire.com/api/characters/28           Unella
## 9  https://www.anapioficeandfire.com/api/characters/29 Abelar Hightower
## 10 https://www.anapioficeandfire.com/api/characters/30       Addam Frey
##    gender culture      born                         died
## 1  Female                                               
## 2    Male                                               
## 3    Male                                               
## 4    Male                                               
## 5  Female                                               
## 6    Male                                               
## 7    Male         In 242 AC In 300 AC, at King's Landing
## 8  Female                                               
## 9    Male                                               
## 10   Male                                               
##                                                                                                                       titles
## 1                                                                                                                      Septa
## 2                                                                                                                     Septon
## 3                                                                                                                     Septon
## 4                                                                                                                     Septon
## 5                                                                                                                      Septa
## 6                                                                                                                     Septon
## 7  Lord of Casterly Rock, Shield of Lannisport, Warden of the West, Hand of the King, Savior of the City (of King's Landing)
## 8                                                                                                                      Septa
## 9                                                                                                                        Ser
## 10                                                                                                                       Ser
##                                                            aliases father
## 1                                                                        
## 2                                                                        
## 3                                                                        
## 4                                                                        
## 5                                                                        
## 6                                                                        
## 7  The Lion of Lannister, The Old Lion, The Great Lion of the Rock       
## 8                                                                        
## 9                                                                        
## 10                                                                       
##    mother                                               spouse
## 1                                                             
## 2                                                             
## 3                                                             
## 4                                                             
## 5                                                             
## 6                                                             
## 7         https://www.anapioficeandfire.com/api/characters/562
## 8                                                             
## 9                                                             
## 10                                                            
##                                         allegiances
## 1                                                  
## 2                                                  
## 3                                                  
## 4                                                  
## 5                                                  
## 6                                                  
## 7  https://www.anapioficeandfire.com/api/houses/229
## 8                                                  
## 9  https://www.anapioficeandfire.com/api/houses/195
## 10 https://www.anapioficeandfire.com/api/houses/143
##                                                                                                                                                                                                                                                                                        books
## 1                                                                                                                                                https://www.anapioficeandfire.com/api/books/3, https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 2                                                                                                                                                                                               https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 3                                                                                                                                                                                                                                              https://www.anapioficeandfire.com/api/books/2
## 4                                                                                                                                                                                               https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 5                                                                                                                                                                                               https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 6                                                                                                                                                                                               https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 7  https://www.anapioficeandfire.com/api/books/1, https://www.anapioficeandfire.com/api/books/2, https://www.anapioficeandfire.com/api/books/3, https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8, https://www.anapioficeandfire.com/api/books/11
## 8                                                                                                                                                                                               https://www.anapioficeandfire.com/api/books/5, https://www.anapioficeandfire.com/api/books/8
## 9                                                                                                                                                                                                                                              https://www.anapioficeandfire.com/api/books/4
## 10                                                                                                                                                                                                                                             https://www.anapioficeandfire.com/api/books/7
##    povBooks                               tvSeries          playedBy
## 1      NULL                                                         
## 2      NULL                                                         
## 3      NULL                                                         
## 4      NULL                                                         
## 5      NULL                                                         
## 6      NULL                                                         
## 7      NULL Season 1, Season 2, Season 3, Season 4     Charles Dance
## 8      NULL                     Season 5, Season 6 Hannah Waddingham
## 9      NULL                                                         
## 10     NULL                                                         
## $category
## [1] "Success"
## 
## $reason
## [1] "OK"
## 
## $message
## [1] "Success: (200) OK"
## 
## [1] FALSE
```





### Submission

Please follow the [instructions](/Exercises/homework_submission_instructions.md) to submit your homework. The homework is due on Monday, November 19 at 5pm.
