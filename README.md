# combat
Batch correction

Build a docker image, then run like so:
```
docker run --rm -v `pwd`:/data jeltje/combat -b batch_info.tsv -e gene_by_sample_matrix.tsv -o corrected.tsv
```

The gene by sample matrix should look like this:
```
gene_id                 sample1 sample2 sample3 (...)
ENSG00000000005.5       1.87    2.66    0.74
ENSG00000000419.12      9.2     10.91   10.34
ENSG00000000457.13      7.35    8.26    7.16
(...)
```

The batch info file groups the samples by a characteristic such as tissue or tumor type:
```
id	Batch
sample1	liver
sample2 liver
sample3 lung
(...)
```


