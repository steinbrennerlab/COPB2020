library("ggplot2")
library("treeio")
library("phytools") # for sims and ASRs
library("EBImage") # for images
library("ggtree")
library("optparse")
library("tidytree")

dir1 <- paste(getwd(),"/AT2G32680.1/combinedtree.nwk", sep='')
message(dir1)

#Takes in merged_coding file from blast_align_tree
dir2 <- paste(getwd(),"/AT2G32680.1/merged_coding.txt", sep='')
message(dir2)


tree <- read.tree(dir1)
tree<-drop.tip(tree,240)
tree<-drop.tip(tree,345)
tree<-drop.tip(tree,383)

q <- ggtree(tree)
q <- scaleClade(q, 927, 0.4) %>% collapse(927, 'max', fill="#cb2313")  #19 genes
q <- collapse(q, 972, 'max', fill="#cb2313")  #4 genes
q <- collapse(q, 976, 'max', fill="#cb2313")  #4 genes
q <- collapse(q, 966, 'min', fill="#cb2313")  #6 genes
q <- collapse(q, 949, 'max', fill="#cb2313")  #7 genes
q <- collapse(q, 899, 'max', fill="#4a6630")  #11 genes
q <- collapse(q, 1011, 'max', fill="#4a6630")  #8 genes

q <- viewClade(q, MRCA(q, 890, 990))

dd <- read.table(dir2, sep="\t", header = TRUE, stringsAsFactor=F)
q <- q %<+% dd

dir3 <- paste(getwd(),"/labels.txt", sep='')
dd3 <- read.table(dir3, sep="\t", header = TRUE, stringsAsFactor=F)
message(dd3)
q <- q %<+% dd3

file <- paste(getwd(),"/AT2G32680.1/output/final.pdf", sep='')
pdf(file)
q +
	geom_tiplab(size=1,offset=0.05,aes(color=hit,fontface="bold")) + #tip labels (gene names)
	geom_tiplab(aes(label=symbol,color=hit), size=1,align=T, linetype=NA) + #gene symbol names
	geom_hilight(node=915, fill="darkgreen", alpha=.3, extend=2) + #highlight RLP42 box
	scale_colour_manual(values=c("#cb2313","#4a6630","#0014c2","#ffa519")) #5 colors in osat slyc tair vung zmays order
dev.off()

sessionInfo()