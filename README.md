# Dynamical Network Biomarkers

An R package to calculate Dynamical Network Biomarkers (DNB).

For more information, see:

[Chen L, Liu R, Liu Z-P, Li M, Aihara K. Detecting early-warning signals for sudden deterioration of complex diseases by dynamical network biomarkers. Scientific Reports. 2012;2:342. doi:10.1038/srep00342](https://www.nature.com/articles/srep00342)



## Install

```R
library(devtools)
install_github("gpli/DNB")
```

## Usage
New DNB object, `group` is NULL by default if no control group (normal samples)
```R
library(DNB)
dnb <- new(data = gene_expr,
           time = as.factor(sample_info$time),
           group = sample_info$group)
dnb
```

Calculate DNB
```R
dnb <- cal_cor(dnb)
dnb <- cal_cv(dnb)
dnb <- search_candidates(dnb, min_size = 20, max_size = 100, with_ctrl = T)
dnb <- cal_final(dnb, with_ctrl = T)
```

Export results
```R
dnb_genes <- get_DNB_genes(dnb)
candidates <- get_candidates(dnb)
plot_DNB(candidates, "DNB_candidates.pdf")
final <- get_final(dnb)
plot_DNB(final, "DNB_final.pdf")
```
