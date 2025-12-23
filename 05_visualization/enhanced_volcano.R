# Enhanced volcano plot for bulk RNA-seq differential expression
# Input: DESeq2 results table
# Output: publication-quality volcano plot

library(readr)
library(dplyr)
library(EnhancedVolcano)

# -----------------------------
# Load DE results
# -----------------------------
# Expected columns:
# gene, log2FoldChange, pvalue, padj
de <- read_tsv("deseq2_results.tsv")

# -----------------------------
# Volcano plot
# -----------------------------
EnhancedVolcano(
  de,
  lab = de$gene,
  x = "log2FoldChange",
  y = "pvalue",
  pCutoff = 0.05,
  FCcutoff = 1.0,
  pointSize = 2.5,
  labSize = 3.0,
  title = "Differential Expression: Treated vs Control",
  subtitle = "Bulk RNA-seq",
  caption = "DESeq2 results",
  legendPosition = "right",
  legendLabSize = 10,
  legendIconSize = 4
)

# ggsave("EnhancedVolcano_DESeq2.png", width = 7, height = 6)
