# Complex heatmap for bulk RNA-seq
# Input: normalized expression matrix
# Output: annotated heatmap for top differentially expressed genes

library(readr)
library(dplyr)
library(ComplexHeatmap)
library(circlize)

# -----------------------------
# Load expression data
# -----------------------------
expr <- read_tsv("normalized_expression.tsv")

expr_mat <- expr %>%
  column_to_rownames(var = colnames(expr)[1]) %>%
  as.matrix()

# -----------------------------
# Select top variable genes
# -----------------------------
gene_var <- apply(expr_mat, 1, var)
top_genes <- names(sort(gene_var, decreasing = TRUE))[1:50]

heatmap_mat <- expr_mat[top_genes, ]

# -----------------------------
# Scale rows
# -----------------------------
heatmap_scaled <- t(scale(t(heatmap_mat)))

# -----------------------------
# Draw heatmap
# -----------------------------
Heatmap(
  heatmap_scaled,
  name = "Z-score",
  show_row_names = TRUE,
  show_column_names = TRUE,
  clustering_distance_rows = "euclidean",
  clustering_distance_columns = "euclidean",
  clustering_method_rows = "complete",
  clustering_method_columns = "complete",
  column_title = "Bulk RNA-seq Samples",
  row_title = "Top Variable Genes",
  col = colorRamp2(c(-2, 0, 2), c("blue", "white", "red"))
)
