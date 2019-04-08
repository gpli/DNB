#' Search Candidate DNB genes
#'
#' Cluster by correlation, caculate DNB scores of all subtrees, and get best DNB
#' score for each time point
#' @param dnb a DNB object
#' @param min_size minimum gene number in subtree. Default 2.
#' @param max_size maximum gene number in subtree. Default Inf.
#' @param included_genes genes to be included in subtree. Default NULL.
#' @param all should all \@code{included_genes} be in subtree. Default False.
#' @param with_ctrl if consider control group. Default T.
#' @param verbose output progress.
#' @return a DNB object
#' @export
search_candidates <- function(dnb, min_size = 2, max_size = Inf, included_genes = NULL, all = F, with_ctrl = T, verbose = T) {
    for (tp in levels(dnb$time)) {
        if (verbose) cat("time point", tp, "\n")
        dnb_lite <- NULL
        if (is.null(dim(dnb$correlation[[tp]]))) {
            cat("Loading correlation data files ...\n")
            dnb_lite <- dnb
            dnb$correlation[[tp]] <- get_correlation(dnb, tp)
            if (!is.null(dnb$group) && isTRUE(with_ctrl)) {
                dnb$correlation_ctrl <- get_correlation(dnb, tp, "correlation_ctrl")
            }
        }
        cat("Hierarchical clustering genes ...\n")
        dend <- as.dendrogram(hclust(as.dist(1 - dnb$correlation[[tp]])))
        modules <- dendextend::partition_leaves(dend)
        member_nums <- sapply(modules, length)
        modules <- modules[member_nums >= min_size & member_nums <= max_size]
        if (!is.null(included_genes)) {
            if (all == T) {
                modules <- modules[sapply(modules, function(x) {all(included_genes %in% x)})]
            }
            else {
                modules <- modules[sapply(modules, function(x) {any(included_genes %in% x)})]
            }
        }
        cat("Calculating module attributes...\n")
        module_dnbs <- lapply(modules, function(m) get_DNB_attr(dnb, tp, m, with_ctrl = with_ctrl))
        if (!is.null(dnb_lite)) {
            dnb <- dnb_lite
        }
        dnb$candidates[[tp]] <- module_dnbs[[which.max(sapply(module_dnbs, "[[", "score"))]]
    }
    return(dnb)
}
