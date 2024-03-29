% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cal_cor.R
\name{cal_cor}
\alias{cal_cor}
\title{Calculate Correlation}
\usage{
cal_cor(dnb, adjust_size = T, use_bigcor = F, data_dir = NULL, ...)
}
\arguments{
\item{dnb}{a DNB object}

\item{adjust_size}{adjust sample size}

\item{use_bigcor}{a logical value, use propagate::bigcor to calculate
correlation which will save some memory, and is sometimes fast}

\item{data_dir}{a charactor value, set path to store correlation results
to local RDS files in order to reduce memory pressure}

\item{...}{additional arguments to \code{parpagate::bigcor} or \code{cor}}
}
\value{
a DNB object
}
\description{
Calculate correlation among genes by sample groups
}
