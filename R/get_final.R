#' Get Final DNB
#'
#' Get final DNB as data frame
#' @param dnb a DNB object
#' @return a data frame
#' @export
get_final <- function(dnb) {
    dnb_list2df(dnb$final)
}
