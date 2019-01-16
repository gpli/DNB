# convert DNB list to data frame
dnb_list2df <- function(dnb_list) {
    dnb_df = as.data.frame(do.call(rbind, lapply(dnb_list, function(x) {
        x[[1]] = length(x[[1]])
        unlist(x)
    })))
    dnb_df$time <- as.numeric(names(dnb_list))
    return(dnb_df)
}
