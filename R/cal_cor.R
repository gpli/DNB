#' Calculate Correlation
#'
#' Calculate correlation among genes by sample groups
#' @param dnb a DNB object
#' @param adjust_size adjust sample size
#' @param ... additional arguments to \code{parpagate::bigcor} or \code{cor}
#' @return a DNB object
#' @export
cal_cor <- function(dnb, adjust_size = T, use_bigcor = F, data_dir = NULL, ...) {
    cal_time_point_stats(dnb = dnb, name = "correlation", FUN = function(x){
        x <- t(x)
        if (use_bigcor) {
            r <- propagate::bigcor(x, ...)
            r <- r[1:nrow(r), 1:ncol(r)]
            rownames(r) <- colnames(r) <- colnames(x)
        } else {
            r <- cor(x, ...)
        }
        # adjust sample size
        if ( adjust_size ) {
            r <- r * (1 + (1-r^2)/(2*nrow(x)))
        }
        if (!is.null(data_dir)) {
            cat("Writing RDS file ...\n")
            if (!dir.exists(data_dir)) dir.create(data_dir)
            rds_file <- paste0(data_dir, "/", as.numeric(Sys.time()), ".RDS")
            saveRDS(r, file = rds_file)
            return(rds_file)
        } else {
            return(r)
        }

    })
}
