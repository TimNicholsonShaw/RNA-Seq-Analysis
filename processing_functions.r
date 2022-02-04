# Functions to take a gene signature output from featurecounts
# And a create 1) a DESEQ object
# and 2) a TPM table

#imports
library(DESeq2)
library(tidyverse)

make_genesig_from_file <- function (file_loc, ...) {
    # extra arguments should contain mappings for changing names
    # will likely only work for featureCounts output
    genesig_df <- read.csv(file_loc, header=T, sep="\t", comment="#")
    genesig_df <- rename(genesig_df, ...)[complete.cases(genesig_df),] #only things with everything

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

    return(data.frame(id=sample_names, ...))
}

make_DESeq_object <- function(genesig_df, meta_data, design) {
    genesig_df <- select(genesig_df, -Length)

    dds <- DESeqDataSetFromMatrix(countData=genesig_df,
                                colData=meta_data,
                                design=design,
                                tidy=T)
    return(DESeq(dds))
}

make_results_table <- function(DESeq_object, contrast_vector) {
    # contrast should be in the form of c(column_name, perturbation, control)
    res <- results(DESeq_object, contrast=contrast_vector)

    return(res[order(res$padj),])
}

calculate_tpm <- function(genesig_df) {
        counts <- genesig_df[-(1:2)]
        counts <- counts/(genesig_df$Length/1000) # normalize by kilobase length

        sum_columns = colSums(counts)
        for (i in (1:length(counts))) { # normalize to per million reads
            counts[i] <- (counts[i] / sum_columns[i]) * 1000000
        }
        return(cbind(genesig_df[1:2], counts))
}