# Functions to take a gene signature output from featurecounts
# And a create 1) a DESEQ object
# and 2) a TPM table

#imports
library(DESeq2)
library(tidyverse)

make_genesig_from_file <- function (file_loc, ...) {
    # extra arguments should contain mappings for changing names
    # will likely only work for featureCounts output
    genesig_df <- read_tsv(file_loc, col_names=T, comment="#")
    genesig_df <- rename(genesig_df, ...)

    # drop unused columns
    # still hang onto length, because we can use it in TPM calculations
    # but that would need to be dropped before DESeq
    return(select(genesig_df, -Chr, -Start, -End, -Strand)) 
}

# should end with a mapping of conditions that matches the order of the column names
make_meta_data <- function(genesig_df, ...) {
    # Gets column names from  genesig_df
    # Drops geneid and length
    sample_names <- colnames(genesig_df[-(1:2)])

    return(data.frame(Sample=sample_names, ...))
}

make_DESeq_object <- function(genesig_df, meta_data, design) {

}

make_results_table <- function(DESeq_object, contrast_vector) {

}