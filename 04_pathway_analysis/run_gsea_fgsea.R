# Gene Set Enrichment Analysis (GSEA) for bulk RNA-seq
# Input: DESeq2 results table with log2 fold changes
# Output: pathway enrichment results using fgsea

library(readr)
library(dplyr)
library(fgsea)
library(msigdbr)

# -----------------------------
# Load DESeq2 results
# -----------------------------
# Expected columns:
# gene, log2FoldChange, padj
de <- read_tsv("deseq2_results.tsv")

# Remove missing values
de <- de %>%
  filter(!is.na(log2FoldChange))

# -----------------------------
# Create ranked gene list
# -----------------------------
ranked_genes <- de$log2FoldChange
names(ranked_genes) <- de$gene

ranked_genes <- sort(ranked_genes, decreasing = TRUE)

# -----------------------------
# Load gene sets (MSigDB)
# -----------------------------
msigdb <- msigdbr(
  species = "Mus musculus",
  category = "H"
)

pathways <- msigdb %>%
  split(x = .$gene_symbol, f = .$gs_name)

# -----------------------------
# Run fgsea
# -----------------------------
fgsea_res <- fgsea(
  pathways = pathways,
  stats = ranked_genes,
  minSize = 15,
  maxSize = 500,
  nperm = 10000
)

# -----------------------------
# Format and save results
# -----------------------------
fgsea_res <- fgsea_res %>%
  arrange(padj)

write_tsv(fgsea_res, "gsea_results_hallmark.tsv")

# Optional: show top pathways
head(fgsea_res, 10)
