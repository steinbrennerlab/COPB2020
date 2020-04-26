
library("ggplot2")
library("treeio")
library("phytools") # for sims and ASRs
library("EBImage") # for images
library("ggtree")
library("optparse")


#Takes in the output from FastTree fed by blast_align_tree
dir1 <- paste(getwd(),"/combinedtree.nwk", sep='')
message(dir1)

#Takes in merged_coding file from blast_align_tree
dir2 <- paste(getwd(),"/merged_coding.txt", sep='')
message(dir2)


tree <- read.tree(dir1)

dd <- read.table(dir2, sep="\t", header = TRUE, stringsAsFactor=F)

q <- ggtree(tree, size=0.5)
q <- q %<+% dd
message(q)

pdf("test.pdf", width=3, height=2)
q +

	geom_tiplab(size=1,offset=0.01,aes(color=family)) + 
	xlim(0, 0.3) +
	geom_tiplab(aes(fill=family), offset=0.15,size=2,align=T, linetype=NA) +

	geom_point2(size=1, offset=0.005,aes(color=family))+ scale_colour_brewer(palette = "Dark2")

dev.off()
