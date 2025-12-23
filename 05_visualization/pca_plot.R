# PCA visualization for bulk RNA-seq
# Input: normalized expression matrix (genes x samples)
# Output: PCA plots for exploratory analysis and QC

library(readr)
library(dplyr)
library(ggplot2)

# -----------------------------
# Load normalized expression data
# -----------------------------
# Expected format:
# Rows = genes
# Columns = samples
expr <- read_tsv("normalized_expression.tsv")

# First column assumed to be gene identifiers
expr_mat <- expr %>%
  column_to_rownames(var = colnames(expr)[1]) %>%
  as.matrix()

# -----------------------------
# Perform PCA
# -----------------------------
pca_res <- prcomp(t(expr_mat), scale. = TRUE)

pca_df <- as.data.frame(pca_res$x) %>%
  rownames_to_column(var = "Sample")

# Optional: sample metadata
# metadata <- read_tsv("sample_metadata.tsv")
# pca_df <- left_join(pca_df, metadata, by = "Sample")

# -----------------------------
# Plot PCA
# -----------------------------
ggplot(pca_df, aes(PC1, PC2)) +
  geom_point(size = 3) +
  theme_classic() +
  labs(
    title = "PCA of Bulk RNA-seq Samples",
    x = paste0("PC1 (", round(summary(pca_res)$importance[2, 1] * 100, 1), "%)"),
    y = paste0("PC2 (", round(summary(pca_res)$importance[2, 2] * 100, 1), "%)")
  )

# ggsave("PCA_plot_PC1_PC2.png", width = 6, height = 5)
