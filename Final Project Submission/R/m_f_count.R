#'Print Sum M/F Children Enrolled
#'
#'Print the total number of school children in a state for the 2013-2014 school year separated by gender.
#'
#' @name m_f_count
#' @import magrittr
#'
#' @param x State Abbreviation
#'
#' @return Numeric Vector
#'
#'
#' @examples
#'m_f_count("KS")
#'
#'m_f_count("NY")
#'
#'m_f_count("CA")
#'
#' @export


load("~/KLohMDSFinal/data/CRDCdata.rda")

m_f_count <- function(x) {
  LEA_STATE <- TOT_ENR_F <- TOT_ENR_M <- NULL
  if (x %in% CRDCdata$LEA_STATE) {
    CRDCdata %>% select(LEA_STATE, TOT_ENR_F, TOT_ENR_M) %>%
      dplyr::filter(CRDCdata$LEA_STATE == x) %>%
      summarise_each(funs(sum), TOT_ENR_F, TOT_ENR_M)
  }
  else {
    print("FAIL!")
  }
}
