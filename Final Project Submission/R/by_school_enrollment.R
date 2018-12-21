#'Print School Enrollment By School
#'
#'Print the total number of school children in each school by name for the 2013-2014 school year separated by gender.
#'
#' @name by_school_enrollment
#' @import magrittr
#'
#' @param x SCHOOL NAME
#'
#' @return Numeric Vector
#'
#'
#' @examples
#'by_school_enrollment("KS")
#'
#'by_school_enrollment("NY")
#'
#'by_school_enrollment("CA")
#'
#' @export

by_school_enrollment <- function(x) {
  SCH_NAME <- LEA_STATE <- TOT_ENR_F <- TOT_ENR_M <- NULL
  if (x %in% CRDCdata$SCH_NAME) {
    CRDCdata %>% select(SCH_NAME, LEA_STATE, TOT_ENR_F, TOT_ENR_M) %>%
      dplyr::filter(CRDCdata$SCH_NAME == x)
  }
  else {
    print("FAIL!")
  }
}
