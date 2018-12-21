#'Print Sum Total Children Enrolled
#'
#'Print the total number of school children in a state for the 2013-2014 school year.
#'
#'@name tot_pop
#'
#'@param x State Abbreviation
#'
#'@return Numeric Vector
#'
#'@import dplyr
#'
#'
#'
#'@examples
#'tot_pop("KS")
#'
#'tot_pop("NY")
#'
#'tot_pop("CA")
#'
#'@export
#'

load("~/KLohMDSFinal/data/CRDCdata.rda")


tot_pop <- function(x) {
  LEA_STATE <- TOT_ENR_F <- TOT_ENR_M <- NULL
  if (x %in% CRDCdata$LEA_STATE) {
    CRDCdata %>% select(LEA_STATE, TOT_ENR_F, TOT_ENR_M) %>%
      dplyr::filter(CRDCdata$LEA_STATE == x) %>%
      summarise_each(funs(sum), TOT_ENR_F, TOT_ENR_M) %>%
      sum()
  }
  else {
    print("FAIL!")
  }
}
