#!/usr/bin/env Rscript
# jeltje.van.baren@gmail.com
# Runs ComBat with input parameters
# Based on script by
# Lauren M. Sanders

library("optparse")
suppressPackageStartupMessages(library("sva"))

opt_parser = OptionParser(usage = "usage: %prog [options]\n", option_list= list(
  make_option(c("-b", "--batch"), type="character", default=NULL, 
              help="batch file name", metavar="character"),
  make_option(c("-e", "--expr"), type="character", default=NULL, 
              help="expression dataset file name", metavar="character"),
  make_option(c("-o", "--out"), type="character", default="out.txt", 
              help="output file name [default= %default]", metavar="character")
), description = "A program to run ComBat on a gene by sample matrix", epilogue = ""); 

opt = parse_args(opt_parser);
# options can now be called as opt$file and opt$out

if (is.null(opt$batch)){
  print_help(opt_parser)
  stop("Please submit a batch file.\n", call.=FALSE)
}
if (is.null(opt$expr)){
  print_help(opt_parser)
  stop("Please submit a file with expression data.\n", call.=FALSE)
}
# combat arguments
#> args(ComBat)
#function (dat, batch, mod = NULL, par.prior = TRUE, prior.plots = FALSE,
#    mean.only = FALSE)


# Read in batch file (2 column file with header "id\tBatch"
batches <- read.delim(opt$batch,header=TRUE,row.names=1,stringsAsFactors=T,check.names=F) 

# get batch column
batch = batches$Batch

# Read in gene expression matrix 
indata <- read.delim(opt$expr,header=TRUE,row.names=1,stringsAsFactors=T,check.names=F) 

# Run ComBat
modcombat = model.matrix(~1, data=batches)
combat_data <- ComBat(dat=indata, batch=batch, mod=modcombat, par.prior=TRUE, prior.plots=FALSE)

# Write out data to a new tab delimited file
write.table(combat_data, file=opt$out, quote=FALSE, sep="\t", row.names=TRUE, col.names=NA)

