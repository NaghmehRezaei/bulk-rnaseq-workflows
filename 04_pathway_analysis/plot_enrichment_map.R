# Enrichment map visualization for pathway analysis
# Input: ORA results table
# Output: pathway similarity network

library(readr)
library(dplyr)
library(igraph)
library(ggraph)
library(tidyr)

# -----------------------------
# Load ORA results
# -----------------------------
ora <- read_tsv("ora_results_go_bp.tsv")

# Keep top pathways
ora_top <- ora %>%
  arrange(p.adjust) %>%
  slice(1:30)

# -----------------------------
# Parse gene lists
# -----------------------------
# Expected column: geneID (Entrez IDs separated by "/")
gene_sets <- ora_top %>%
  select(Description, geneID) %>%
  separate_rows(geneID, sep = "/")

# -----------------------------
# Compute pathway overlap
# -----------------------------
edges <- gene_sets %>%
  inner_join(gene_sets, by = "geneID") %>%
  filter(Description.x != Description.y) %>%
  count(Description.x, Description.y, name = "shared_genes") %>%
  filter(shared_genes >= 3)

# -----------------------------
# Build graph
# -----------------------------
graph <- graph_from_data_frame(edges, directed = FALSE)

# -----------------------------
# Plot enrichment map
# -----------------------------
ggraph(graph, layout = "fr") +
  geom_edge_link(aes(width = shared_genes), alpha = 0.6) +
  geom_node_point(size = 4, color = "steelblue") +
  geom_node_text(aes(label = name), repel = TRUE, size = 3) +
  theme_void() +
  labs(
    title = "Pathway Enrichment Map",
    subtitle = "Edges indicate shared genes"
  )

# ggsave("Enrichment_Map.png", width = 8, height = 7)
