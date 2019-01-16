#' Get Candidates
#'
#' Get candidate DNBs as data frame
#' @export
get_candidates <- function(dnb) {
    dnb_list2df(dnb$candidates)
}
