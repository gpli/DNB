#' Get DNB Genes
#'
#' Get DNB genes
#' @param dnb DNB object
#' @return a character vector
#' @export
get_DNB_genes <- function(dnb) {
    dnb$final[[1]][["genes"]]
}
