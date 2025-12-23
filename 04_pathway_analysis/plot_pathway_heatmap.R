# Pathway heatmap across conditions (NES-based)
# Input: multiple GSEA result tables with identical pathway definitions
# Output: pathway x condition heatmap using NES values

library(readr)
library(dplyr)
library(tidyr)
library(ComplexHeatmap)
library(circlize)

# -----------------------------
# Load GSEA results
# -----------------------------
# Each file should contain at least:
# pathway, NES, padj
# Add one file per condition as needed

gsea_cond1 <- read_tsv("gsea_condition1.tsv") %>% mutate(Condition = "Condition_1")
gsea_cond2 <- read_tsv("gsea_condition2.tsv") %>% mutate(Condition = "Condition_2")

# Combine all conditions
gsea_all <- bind_rows(gsea_cond1, gsea_cond2)

# -----------------------------
# Filter pathways
# -----------------------------
gsea_filt <- gsea_all %>%
  filter(padj < 0.1) %>%
  select(pathway, Condition, NES)

# -----------------------------
# Reshape to matrix format
# -----------------------------
heatmap_df <- gsea_filt %>%
  pivot_wider(
    names_from = Condition,
    values_from = NES
  ) %>%
  drop_na()

heatmap_mat <- heatmap_df %>%
  column_to_rownames("pathway") %>%
  as.matrix()

# -----------------------------
# Draw heatmap
# -----------------------------
Heatmap(
  heatmap_mat,
  name = "NES",
  col = colorRamp2(
    c(min(heatmap_mat), 0, max(heatmap_mat)),
    c("blue", "white", "red")
  ),
  clustering_distance_rows = "euclidean",
  clustering_distance_columns = "euclidean",
  clustering_method_rows = "complete",
  clustering_method_columns = "complete",
  row_title = "Pathways",
  column_title = "Conditions"
)

# ggsave("GSEA_pathway_heatmap.png", width = 8, height = 7)
