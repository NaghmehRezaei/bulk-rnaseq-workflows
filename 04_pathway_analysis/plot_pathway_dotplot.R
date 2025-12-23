# Pathway dot plot visualization
# Input: ORA or GSEA results table
# Output: dot plot summarizing enriched pathways

library(readr)
library(dplyr)
library(ggplot2)

# -----------------------------
# Load pathway results
# -----------------------------
# Expected columns (ORA):
# Description, Count, GeneRatio, p.adjust
ora <- read_tsv("ora_results_go_bp.tsv")

# Select top pathways
top_pathways <- ora %>%
  arrange(p.adjust) %>%
  slice(1:20)

# Convert GeneRatio to numeric
top_pathways <- top_pathways %>%
  separate(GeneRatio, into = c("GeneHits", "GeneTotal"), sep = "/", convert = TRUE) %>%
  mutate(GeneRatioNumeric = GeneHits / GeneTotal)

# -----------------------------
# Dot plot
# -----------------------------
ggplot(top_pathways,
       aes(x = GeneRatioNumeric,
           y = reorder(Description, GeneRatioNumeric),
           size = Count,
           color = p.adjust)) +
  geom_point(alpha = 0.8) +
  scale_color_continuous(low = "red", high = "blue", name = "Adjusted p-value") +
  theme_classic() +
  labs(
    title = "Pathway Enrichment (ORA)",
    x = "Gene Ratio",
    y = "Pathway"
  )

# ggsave("ORA_dotplot.png", width = 7, height = 6)
