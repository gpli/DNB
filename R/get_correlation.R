#' Get correlation of a specific time point
#'
#' @param dnb a DNB object
#' @param time_point character name of a time point
#' @param cor_name "correlation" or "correlation_ctrl"
#'
#' @return a correlation matrix
#' @export
#'
#' @examples \dontrun{
#' r <- get_correlation(dnb, "2", "correlation")
#' r_ctrl <- get_correlation(dnb, "2", "correlation_ctrl")
#' }
get_correlation <- function(dnb, time_point, cor_name = "correlation") {
    res <- dnb$correlation[[as.character(time_point)]]
    if (is.null(dim(res))) {
        res <- readRDS(res)
    }
    return(res)
}
