#' Plot DNB
#'
#' Plot DNB attibutes from data frame
#' @param dnb_df a data frame of DNB result.
#' @param file a character string of the output PDF file.
#' @param height,width the width and height of the graphics region in inches.
#' @export
plot_DNB <- function(dnb_df, file="DNB_plot.pdf", height=7, width=7) {
    pdf(file,height = height ,width = width)
    layout(matrix(c(1:4),ncol=2))

    # score
    plot(dnb_df$score,type="l",col = "blue", xaxt = "n" , xlab = "time", ylab = "score")
    points(dnb_df$score,col = "black")
    axis(1,1:nrow(dnb_df),round(dnb_df$time))

    # cor_in
    if (!is.null(dnb_df$cor_in_ctrl)) {
        dnb_df$cor_in <- dnb_df$cor_in / dnb_df$cor_in_ctrl
    }
    plot(dnb_df$cor_in, type="l", col = "blue", xaxt = "n" , xlab = "time", ylab = "cor_in")
    points(dnb_df$cor_in,col = "black")
    axis(1,1:nrow(dnb_df),round(dnb_df$time))

    # cor_out
    if (!is.null(dnb_df$cor_out_ctrl)) {
        dnb_df$cor_out <- dnb_df$cor_out / dnb_df$cor_out_ctrl
    }
    plot(dnb_df$cor_out, type="l", col = "blue", xaxt = "n" , xlab = "time", ylab = "cor_out")
    points(dnb_df$cor_out,col = "black")
    axis(1,1:nrow(dnb_df),round(dnb_df$time))

    # cv
    if (!is.null(dnb_df$cv_in_ctrl)) {
        dnb_df$cv_in <- dnb_df$cv_in / dnb_df$cv_in_ctrl
    }
    plot(dnb_df$cv_in, type="l", col = "blue", xaxt = "n" , xlab = "time", ylab = "CV")
    points(dnb_df$cv_in,col = "black")
    axis(1,1:nrow(dnb_df),round(dnb_df$time))

    dev.off()
}
