#' Calculate Final DNB Genes
#'
#' Compare and get the time point with highest score, and use that set of
#' DNB genes to recalculate DNB attibutes for all time points.
#' @param dnb a DNB object
#' @param with_ctrl if consider control group. Default T.
#' @return a DNB object
#' @export
cal_final <- function(dnb, with_ctrl = T) {
    dnb_genes <- dnb$candidates[[which.max(sapply(dnb$candidates, "[[", "score"))]]$genes
    dnb$final <- lapply(levels(dnb$time), function(tp) {
        dnb_full <- dnb
        if (is.null(dim(dnb$correlation[[tp]]))) {
            cat("Loading correlation data files ...\n")
            dnb_full$correlation[[tp]] <- get_correlation(dnb, tp)
            if (isTRUE(with_ctrl)) {
                dnb_full$correlation_ctrl <- get_correlation(dnb, tp, "correlation_ctrl")
            }
        }
        get_DNB_attr(dnb_full, tp, dnb_genes, with_ctrl = with_ctrl)
    })
    names(dnb$final) <- levels(dnb$time)
    return(dnb)
}
