#' Calculate time point statictics
#'
#' Calculate time point statictics i.e. PCC, CV
#' @param dnb a DNB object
#' @param name statistical item name
#' @param FUN statistical function
#' @param ... additional parameters to FUN
#' @return a DNB object
cal_time_point_stats <- function(dnb, name, FUN) {
    if (is.null(dnb$group)) {
        dnb[[name]] <- list()
        for (time_point in levels(dnb$time)) {
            cat(time_point, "\n")
            dnb[[name]][[time_point]] <- do.call(
                FUN, list(dnb$data[, dnb$time == time_point]))
        }
    } else {
        dnb[[name]] <- list()
        dnb[[paste0(name, "_ctrl")]] <- list()
        for (time_point in levels(dnb$time)) {
            cat(time_point, "(case)\n")
            dnb[[name]][[time_point]] <- do.call(
                FUN, list(dnb$data[, dnb$time == time_point & dnb$group == 1]))
            cat(time_point, "(control)\n")
            dnb[[paste0(name, "_ctrl")]][[time_point]] <- do.call(
                FUN, list(dnb$data[, dnb$time == time_point & dnb$group == 0]))
        }
    }
    return(dnb)
}
