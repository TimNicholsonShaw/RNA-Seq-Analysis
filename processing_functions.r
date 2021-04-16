# Functions to take a gene signature output from featurecounts
# And a create 1) a DESEQ object
# and 2) a TPM table

#imports
library(DESeq2)


make_genesig_from_file <- function (file_loc, sample_names_in_order) {
}

make_meta_data <- function(genesig_df, some_mapping_of_conditions) {

}

make_DESeq_object <- function(genesig_df, meta_data, design) {

}

make_results_table <- function(DESeq_object, contrast_vector) {
    
}