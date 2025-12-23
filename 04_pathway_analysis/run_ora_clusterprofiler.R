# Over-Representation Analysis (ORA) for bulk RNA-seq
# Input: list of significantly differentially expressed genes
# Output: enriched biological pathways

library(readr)
library(dplyr)
library(clusterProfiler)
library(org.Mm.eg.db)

# -----------------------------
# Load DESeq2 results
# -----------------------------
# Expected columns:
# gene, log2FoldChange, padj
de <- read_tsv("deseq2_results.tsv")

# -----------------------------
# Select significant genes
# -----------------------------
sig_genes <- de %>%
  filter(padj < 0.05, abs(log2FoldChange) >= 1) %>%
  pull(gene)

# -----------------------------
# Convert gene symbols to Entrez IDs
# -----------------------------
gene_df <- bitr(
  sig_genes,
  fromType = "SYMBOL",
  toType = "ENTREZID",
  OrgDb = org.Mm.eg.db
)

# -----------------------------
# Run ORA (GO Biological Process)
# -----------------------------
ego <- enrichGO(
  gene = gene_df$ENTREZID,
  OrgDb = org.Mm.eg.db,
  keyType = "ENTREZID",
  ont = "BP",
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05,
  qvalueCutoff = 0.05,
  readable = TRUE
)

# -----------------------------
# Save results
# -----------------------------
ora_results <- as.data.frame(ego)

write_tsv(ora_results, "ora_results_go_bp.tsv")

# Optional: preview
head(ora_results, 10)
