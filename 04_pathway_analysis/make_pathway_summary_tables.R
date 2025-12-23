# Pathway summary tables for PI-facing review
# Input: GSEA results table (fgsea output)
# Output: concise ranked pathway summary tables

library(readr)
library(dplyr)

# -----------------------------
# Load GSEA results
# -----------------------------
# Expected columns:
# pathway, NES, padj, size
gsea <- read_tsv("gsea_results.tsv")

# -----------------------------
# Clean and annotate
# -----------------------------
gsea_summary <- gsea %>%
  mutate(
    Direction = ifelse(NES > 0, "Upregulated", "Downregulated")
  ) %>%
  arrange(padj)

# -----------------------------
# Select top pathways
# -----------------------------
top_pathways <- gsea_summary %>%
  filter(padj < 0.05) %>%
  select(
    Pathway = pathway,
    NES,
    Direction,
    Adjusted_P_value = padj,
    Pathway_Size = size
  ) %>%
  slice(1:25)

# -----------------------------
# Save tables
# -----------------------------
write_tsv(top_pathways, "PI_pathway_summary_top25.tsv")

# Optional: separate tables by direction
write_tsv(
  filter(top_pathways, Direction == "Upregulated"),
  "PI_pathway_summary_upregulated.tsv"
)

write_tsv(
  filter(top_pathways, Direction == "Downregulated"),
  "PI_pathway_summary_downregulated.tsv"
)

# Preview
top_pathways
