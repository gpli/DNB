#' Calculate time point statictics
#'
#' Calculate time point statictics i.e. PCC, CV
#' @param dnb a DNB object
#' @param name statistical item name
#' @param FUN statistical function
#' @param ... additional parameters to FUN
#' @return a DNB object
cal_time_point_stats <- function(dnb, name, FUN, ...) {
    if (is.null(dnb$group)) {
        for (time_point in levels(dnb$time)) {
            dnb[[name]][[time_point]] <- do.call(
                FUN, list(dnb$data[, dnb$time == time_point], ...))
        }
    } else {
        for (time_point in levels(dnb$time)) {
            dnb[[name]][[time_point]] <- do.call(
                FUN, list(dnb$data[, dnb$time == time_point & dnb$group == 1], ...))
            dnb[[paste0(name, "_ctrl")]][[time_point]] <- do.call(
                FUN, list(dnb$data[, dnb$time == time_point & dnb$group == 0], ...))
        }
    }
    return(dnb)
}
