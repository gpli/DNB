print.DNB <- function(x) {
    cat("$data\n")
    ramify::pprint(x$data)
    cat("\n")
    print(x[c("time","group")], quote = F)
    for (name in intersect(c("correlation", "correlation_ctrl"), names(x))) {
        cat("$", name, "\n", sep = "")
        cat("list of length", length(x[[name]]), "\n")
        cat("[[1]]", "\n")
        cat("time point \"", levels(x$time)[1], "\"\n", sep = "")
        ramify::pprint(x[[name]][[1]])
        cat("\n...\n\n")
    }
    for (name in intersect(c("CV", "CV_ctrl"), names(x))) {
        cat("$", name, "\n", sep = "")
        cat("list of length", length(x[[name]]), "\n")
        cat("[[1]]", "\n")
        cat("time point \"", levels(x$time)[1], "\"\n", sep = "")
        print_vector(x[[name]][[1]])
        cat("\n...\n\n")
    }
    if ("candidates" %in% names(x)) {
        cat("$candidates\n", sep = "")
        print(dnb_list2df(dnb$candidates))
        cat("\n")
    }
    if ("final" %in% names(x)) {
        cat("$final\n", sep = "")
        print(dnb$final[[1]]$genes)
        print(dnb_list2df(dnb$final))
    }
}

print_vector <- function(x) {
    y <- format(c(x[1:3], x[length(x)]), digits = 7)
    print(c(y[1:3], "...", y[4]), quote = F)
}
