Dynamical Network Biomarkers
================

⚠️ **This repository is based on the very early version of DNB, please refer to the latest paper for your research.**

An R package to calculate Dynamical Network Biomarkers (DNB).

For more information, see:

[Chen L, Liu R, Liu Z-P, Li M, Aihara K. Detecting early-warning signals
for sudden deterioration of complex diseases by dynamical network
biomarkers. Scientific Reports. 2012;2:342.
doi:10.1038/srep00342](https://www.nature.com/articles/srep00342)

## Install

``` r
devtools::install_github("gpli/DNB")
```

## Quick start

``` r
library(DNB)

# Load data
gene_expr <- read.csv(system.file("extdata", "gene_expr.csv", package = "DNB"), row.names = 1)
sample_info <- read.csv(system.file("extdata", "sample_info.csv", package = "DNB"), row.names = 1)

# New DNB object
# all-zero genes at any time point will be removed
dnb <- new_DNB(data = gene_expr,
               time = as.factor(sample_info$time))

# Calulate correlation and coefficient of variation
dnb <- cal_cor(dnb)
dnb <- cal_cv(dnb)

# Search DNB
dnb <- search_candidates(dnb, min_size = 20, max_size = 100)
dnb <- cal_final(dnb)

# Get results
dnb_genes <- get_DNB_genes(dnb)
candidates <- get_candidates(dnb)
plot_DNB(candidates)
```

![](README_files/figure-gfm/quick-start-1.png)<!-- -->

``` r
final <- get_final(dnb)
plot_DNB(final)
```

![](README_files/figure-gfm/quick-start-2.png)<!-- -->

## Usage

### Normal samples

Set `group` in `new_DNB` to define normal samples (control group).

``` r
dnb <- new_DNB(data = gene_expr,
               time = as.factor(sample_info$time),
               group = as.factor(sample_info$group))
```

By default, control group will be considered during searching DNB, but
you can still change your mind by set `with_ctrl = F` in
`search_candidates` and `cal_final`. This is useful for tuning
parameters.

### Calculating correlation

Calculating correlation are often memory consuming if there are too many
genes, and difficult to load them all if there are too many time points.
You can set `use_bigcor = T` to calculate correlation with
`propagate::bigcor` and/or set `data_dir` to store correlation data to
local, i.e.

``` r
cal_cor(dnb, use_bigcor = T, data_dir = "tmp")
```

It is recommended to pre-filter low expression genes, which will improve
calculation speed.

### Output

`plot_DNB` use `ggplot2` to draw results. You can set `outfile` to write
into a image file. Further arguments were passed to `ggplot2::ggsave`.

``` r
plot_DNB(final, "DNB_final.pdf")
```
