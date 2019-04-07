#' New DNB Object
#'
#' Create a DNB object
#' @export
#' @param data a gene expression matrix/data frame with sample as column names
#' and gene as row names.
#' @param time a factor of time points.
#' @param group a factor of 0 and 1 for control and case groups, Default NULL.
#' @return a DNB object
#' @details Genes with all-zero expression at any time point will be removed.
#' @examples
#' dnb <- new(data = gene_expr,
#'            time = as.factor(sample_info$time),
#'            group = as.factor(sample_info$group))
#' dnb

new <- function(data, time, group = NULL) {
    # Check time points
    if (!is.factor(time)) {
        stop("factor required for time points")
    }
    if (length(levels(time)) < 3) {
        stop("3 or more time points are required")
    }

    # Remove all-zero genes at any time point (in any group)
    time_points <- time
    if (!is.null(group)) {
        time_points <- paste(time, group, sep = "_")
    }
    gene_count <- nrow(data)
    data <- data[apply(data, 1, function(x) {
        !any(tapply(x, time_points, sum) == 0)
    }),]
    if (nrow(data) != gene_count) {
        warning(paste(gene_count - nrow(data), "genes removed due to all-zero expression at some time points"))
    }

    # Return
    dnb <- list(data = as.matrix(data), time = time, group = group)
    class(dnb) <- "DNB"
    return(dnb)
}
