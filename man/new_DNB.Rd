% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/new_DNB.R
\name{new_DNB}
\alias{new_DNB}
\title{New DNB Object}
\usage{
new_DNB(data, time, group = NULL)
}
\arguments{
\item{data}{a gene expression matrix/data frame with sample as column names
and gene as row names.}

\item{time}{a factor of time points.}

\item{group}{a factor of 0 and 1 for control and case groups, Default NULL.}
}
\value{
a DNB object
}
\description{
Create a DNB object
}
\details{
Genes with all-zero expression at any time point will be removed.
}
\examples{
dnb <- new(data = gene_expr,
           time = as.factor(sample_info$time),
           group = as.factor(sample_info$group))
dnb
}
