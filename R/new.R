#' New DNB Object
#'
#' Create a DNB object by specifying parameters
#' @param data a gene expression matrix/data frame with sample as column names
#' and gene as row names.
#' @param time an factor of time points.
#' @param group a vector of 0 and 1 for control and case groups, Default NULL.
#' @return a DNB object
#' @export
new <- function(data, time, group = NULL) {
    if (!is.factor(time)) {
        stop("factor required for time points")
    }
    if (length(levels(time)) < 3) {
        stop("3 or more time points are required")
    }
    dnb <- list(data = as.matrix(data), time = time, group = group)
    class(dnb) <- "DNB"
    return(dnb)
}
