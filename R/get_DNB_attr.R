#' Get DNB Attributions
#'
#' Calculate DNB score for given genes and return related parameters
get_DNB_attr <- function(dnb, time_point, genes_in, with_ctrl = T) {
    correlation <- dnb$correlation[[time_point]]
    cv <- dnb$CV[[time_point]]

    genes_out <- setdiff(names(cv), genes_in)
    cor_in <- mean(as.dist(correlation[genes_in, genes_in]))
    cor_out <- mean(correlation[genes_in, genes_out])
    cv_in <- mean(cv[genes_in])

    # score
    score <- cv_in * cor_in / cor_out

    # join control samples
    if (!is.null(dnb$group) && isTRUE(with_ctrl)) {
        correlation_ctrl <- dnb$correlation_ctrl[[time_point]]
        cv_ctrl <- dnb$CV_ctrl[[time_point]]

        cv_in_ctrl <- mean(cv_ctrl[genes_in])
        cor_in_ctrl <- mean(as.dist(correlation_ctrl[genes_in, genes_in]))
        cor_out_ctrl <- mean(correlation_ctrl[genes_in, genes_out])
        score <- score / cv_in_ctrl * cor_out_ctrl / cor_in_ctrl
        return(list(genes = genes_in,
                    cv_in = cv_in,
                    cor_in = cor_in,
                    cor_out = cor_out,
                    cv_in_ctrl = cv_in_ctrl,
                    cor_in_ctrl = cor_in_ctrl,
                    cor_out_ctrl = cor_out_ctrl,
                    score = score))
    } else {
        return(list(genes = genes_in,
                    cv_in = cv_in,
                    cor_in = cor_in,
                    cor_out = cor_out,
                    score = score))
    }
}
