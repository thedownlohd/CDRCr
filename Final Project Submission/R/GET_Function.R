#' @name GET_CRDCdata
#'
#' @title GET request to API for CRDCdata
#' Imports the most up-to-date dataset from the CRDC website and creates a useable dataframe.
#' A static version of the dataset is also available as part of this pacakge.
#'
#'
#' @param api_key The unique API Key assigned to each user. Please sign up for one here: "https://usedgov.github.io/key/"
#'
#' @import httr
#' @import jsonlite
#'
#' @return A useable dataframe containing Public School Enrollment data for the 2013-2014 school year. .
#'
#'
#'@export



CRDC_api <- function(api_key){
  pages <- list()
  for(i in 1:10){
    mydata <- fromJSON(toJSON(content(GET(paste0("https://api.ed.gov/data/crdc_enrollment_2013-14", "?", "api_key=", api_key, "&per_page=10000", "&page=", i)))))

    message("Retrieving page ", i)

    pages[[i+1]] <- mydata$resources
  }
  organizations <- rbind_pages(pages)
  test <- organizations
  test[] <- lapply(organizations, function(x) as.vector(as.character(x)))
  xy.list <- split(test, seq(nrow(test)))
  new_df <- do.call("rbind", xy.list)

  testdf <- new_df

  id = 5:40
  testdf[id] = data.matrix(testdf[id])
  sapply(testdf, class)

  testdf
  testdf[id] = as.numeric(unlist(testdf[id]))

  id = 42:66 # column ids to change
  testdf[id] = data.matrix(testdf[id])
  sapply(testdf, class)

  testdf
  testdf[id] = as.numeric(unlist(testdf[id]))

  pages <- list()
  CRDC_api <- function(api_key){
    for(i in 1:10){
      mydata <- fromJSON(toJSON(content(GET(paste0("https://api.ed.gov/data/crdc_enrollment_2013-14", "?", "api_key=", api_key, "&per_page=10000", "&page=", i)))))

      message("Retrieving page ", i)

      pages[[i+1]] <- mydata$resources
    }
    organizations <- rbind_pages(pages)
    test <- organizations
    test[] <- lapply(organizations, function(x) as.vector(as.character(x)))
    xy.list <- split(test, seq(nrow(test)))
    new_df <- do.call("rbind", xy.list)

    testdf <- new_df

    id = 5:40
    testdf[id] = data.matrix(testdf[id])
    sapply(testdf, class)

    testdf
    testdf[id] = as.numeric(unlist(testdf[id]))

    id = 42:66 # column ids to change
    testdf[id] = data.matrix(testdf[id])
    sapply(testdf, class)

    testdf
    testdf[id] = as.numeric(unlist(testdf[id]))

    CRDCdata <- testdf

    return(CRDCdata)
  }
}
