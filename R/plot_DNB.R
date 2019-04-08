#' Plot DNB
#'
#' Plot DNB attibutes from data frame
#' @param dnb_df a data frame of DNB result.
#' @param outfile a character string of the output image file.
#' @param ... additional arguments to ggplot2::ggsave
#' @export
plot_DNB <- function(dnb_df, outfile = NULL, ...) {
    # score
    p_score <- plot_DNB_attr(dnb_df, "score")

    # cor_in
    if (!is.null(dnb_df$cor_in_ctrl)) {
        dnb_df$cor_in <- dnb_df$cor_in / dnb_df$cor_in_ctrl
    }
    p_cor_in <- plot_DNB_attr(dnb_df, "cor_in")

    # cor_out
    if (!is.null(dnb_df$cor_out_ctrl)) {
        dnb_df$cor_out <- dnb_df$cor_out / dnb_df$cor_out_ctrl
    }
    p_cor_out <- plot_DNB_attr(dnb_df, "cor_out")

    # cv
    if (!is.null(dnb_df$cv_in_ctrl)) {
        dnb_df$cv_in <- dnb_df$cv_in / dnb_df$cv_in_ctrl
    }
    p_cv <- plot_DNB_attr(dnb_df, "cv_in")

    p_merge <- cowplot::plot_grid(p_score, p_cor_in, p_cor_out, p_cv)
    if (is.null(outfile)) {
        return(p_merge)
    } else {
        ggplot2::ggsave(filename = outfile, plot = p_merge, ...)
    }
}

plot_DNB_attr <- function(dnb_df, attr_name) {
    ggplot2::ggplot(dnb_df, ggplot2::aes_string("time", attr_name)) +
        ggplot2::geom_line(color = "blue") +
        ggplot2::geom_point(shape = 21, size = 3) +
        ggplot2::theme_classic()
}

