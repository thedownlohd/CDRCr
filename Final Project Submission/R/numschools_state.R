#'Print Sum Total Schools in State
#'
#'Print the total number of schools in a state for the 2013-2014 school year.
#'
#'@name numschools_state
#'
#'@param x State Abbreviation
#'
#'@return Numeric Vector
#'
#'@examples
#'numschools_state("KS")
#'
#'numschools_state("NY")
#'
#'numschools_state("CA")
#'
#'@export
#'

load("~/KLohMDSFinal/data/CRDCdata.rda")



numschools_state <- function(x) {
  LEA_STATE <- NULL
  if (x %in% CRDCdata$LEA_STATE) {
    count(filter(CRDCdata, LEA_STATE == x))
  } else {
    print("This is not a state!")
  }
}
