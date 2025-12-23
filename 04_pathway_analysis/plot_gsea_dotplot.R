# GSEA-specific dot plot (NES-based)
# Input: GSEA results table (fgsea output)
# Output: NES-based dot plot summarizing enriched pathways

library(readr)
library(dplyr)
library(ggplot2)

# -----------------------------
# Load GSEA results
# -----------------------------
# Expected columns:
# pathway, NES, padj, size
gsea <- read_tsv("gsea_results.tsv")

# -----------------------------
# Select significant pathways
# -----------------------------
gsea_sig <- gsea %>%
  filter(padj < 0.05) %>%
  arrange(desc(abs(NES))) %>%
  slice(1:20)

# -----------------------------
# Dot plot (NES-based)
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
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey50") +
  scale_color_continuous(
    low = "red",
    high = "blue",
    name = "Adjusted p-value"
  ) +
  theme_classic() +
  labs(
    title = "GSEA Pathway Enrichment",
    subtitle = "Normalized Enrichment Score (NES)",
    x = "NES",
    y = "Pathway"
  )

# ggsave("GSEA_NES_dotplot.png", width = 7, height = 6)
