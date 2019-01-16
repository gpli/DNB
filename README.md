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
```

The content of `dnb` could be viewed as
```
> dnb
$data
1873 x 74 matrix of doubles:

             s_1       s_2       s_3 ...      s_74
g_1    1.0165000 0.3788000 1.0656000 ... 0.4657000
g_2    0.2707000 0.2707000 0.2707000 ... 0.2707000
g_3    0.3087000 0.3087000 0.3087000 ... 0.3087000
...          ...       ...       ... ...       ...
g_1873 0.9573000 0.6247000 1.3857000 ... 1.3625000

$time
 [1] 6 6 6 6 3 3 2 2 3 3 4 4 4 4 2 2 2 2 2 2 4 4 6 6 6 6 6 6 6 6 4 4 5 5 2 2 6 6 3 3 3 3 5 5 5 5 5 5 5 5 5 5
[53] 6 6 6 6 6 6 4 4 3 3 5 5 4 4 4 4 6 6 6 6 6 6
Levels: 2 3 4 5 6

$group
 [1] 0 1 1 0 1 0 1 0 0 1 0 1 0 1 0 1 0 1 1 0 0 1 1 0 0 1 1 0 0 1 0 1 0 1 0 1 0 1 1 0 1 0 1 0 0 1 0 1 1 0 1 0
[53] 0 1 1 0 1 0 1 0 1 0 0 1 0 1 1 0 1 0 0 1 1 0
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
