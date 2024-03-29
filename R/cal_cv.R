#' Calculate Coefficient of Variation
#'
#' Calculate coefficient of variation among genes by sample groups
#' @param dnb a DNB object
#' @param adjust_size adjust sample size
#' @return a DNB object
#' @export
cal_cv <- function(dnb, adjust_size = T) {
    cal_time_point_stats(dnb = dnb, name = "CV", FUN = function(x) {
        x <- t(x)
        cv <- apply(x,2,sd) / colMeans(x)
        # adjust sample size
        if ( adjust_size ) {
            cv <- (1 + 1/(4*nrow(x))) * cv
        }
        return(cv)
    })
}
