#'Print Graph of X, Y data
#'
#'Uses a provides geom_point() graph of a dataframe a \code{y} columns TBD.
#'@name graphit
#'
#'@import ggplot2
#'
#'@param data Appropriate dataframe, in this case "graph_table"
#'
#'@param column1 Selected column within the dataframe, in this case "Percentage"
#'
#'@return graphit
#'
#'@examples graphit(graph_table, "Percentage")
#'
#'@export
NULL
column1 <- NULL
graphit <- function(data, column1) {
  ggplot(data=data, aes_string(x="Abbreviation", y = column1)) + geom_point(alpha=1/4) + ggtitle(column1) + theme(axis.text.x = element_text(angle = 90))
}
