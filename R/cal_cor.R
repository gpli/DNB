#' Calculate Correlation
#'
#' Calculate correlation among genes by sample groups
#' @param dnb a DNB object
#' @param adjust_size adjust sample size
#' @return a DNB object
#' @export
cal_cor <- function(dnb, adjust_size = T) {
    cal_time_point_stats(dnb = dnb, name = "correlation", FUN = function(x, adjust_size = T){
        x <- t(x)
        r <- suppressWarnings(cor(x))
        r[is.na(r)] <- 0
        # adjust sample size
        if ( adjust_size ) {
            r <- r * (1 + (1-r^2)/(2*nrow(x)))
        }
        return(r)
    }, adjust_size = adjust_size)
}
