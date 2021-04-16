# Functions for making cool graphs of RNA Seq data

# imports
library(ggplot2)

plot_pca <- function(DESeq_object, metadata) {
    # Taken from UCSD BIOM262 2017
    # This only works if it has a condition and batch
    # One day I will code this to be more flexible
    rld <- rlog(DESeq_object)

    data <- plotPCA(rld, intgroup="condition", returnData=TRUE)
    data$batch <- as.factor(metadata$batch)

    percentVar <- round(100 * attr(data, "percentVar"))
    p <- ggplot(data, aes(PC1, PC2, color=condition, shape=batch)) +
            geom_point(size=3) +
            xlab(paste0("PC1: ",percentVar[1],"% variance")) +
            ylab(paste0("PC2: ",percentVar[2],"% variance"))

    return(p)
}

plot_sample_distances <- function(DESeq_object) {

}

plot_volcano <- function(results_table) {

}

plot_volcano_facet_gene_type <- function(results_table, gene_type_vector) {

}

