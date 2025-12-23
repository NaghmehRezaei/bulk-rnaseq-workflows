# GSEA-specific dot plot (NES-based)
# Input: fgsea results table
# Output: NES-based dot plot for enriched pathways

library(readr)
library(dplyr)
library(ggplot2)

# -----------------------------
# Load GSEA results
# -----------------------------
# Expected columns (fgsea):
# pathway, NES, padj, size
gsea <- read_tsv("gsea_results_hallmark.tsv")

# -----------------------------
# Select significant pathways
# -----------------------------
gsea_sig <- gsea %>%
  filter(padj < 0.05) %>%
  arrange(desc(abs(NES))) %>%
  slice(1:20)

# -----------------------------
# Dot plot
# -----------------------------
ggplot(
  gsea_sig,
  aes(
    x = NES,
    y = reorder(pathway, NES),
    size = size,
    color = padj
  )
) +
  geom_point(alpha = 0.85) +
  scale_color_continuous(
    low = "red",
    high = "blue",
    name = "Adjusted p-value"
  ) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey40") +
  theme_classic() +
  labs(
    title = "GSEA Pathway Enrichment",
    subtitle = "Hallmark gene sets (NES-based)",
    x = "Normalized Enrichment Score (NES)",
    y = "Pathway"
  )

# ggsave("GSEA_NES_dotplot.png", width = 7, height = 6)
