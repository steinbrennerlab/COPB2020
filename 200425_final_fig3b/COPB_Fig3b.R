library(genoPlotR)

print("READING GB FILES")
#Reads all .gb files
file.names <- dir(getwd(), pattern ="\\.gb$")
print(file.names)
j <- 1
segs <- vector("list",0)
genbanks <- vector("list",0)
for(i in 1:length(file.names)){
  message(file.names[i])
  seg <- read_dna_seg_from_file(file.names[i],tagsToParse = c("gene"),gene_type = "arrows",col="black")
  name <- file.names[i]
  print(i)
  print(name)
  segs[[j]] <- seg
  genbanks[[j]] <- name
  j <- j+1
}
message(segs)
print("Adding DNAsegs")
names(segs) <- genbanks

print("Reading comparisons from txt files")
file.names <- dir(getwd(), pattern ="\\.txt$")
j <- 1
comps <- vector("list",0)
for(i in 1:length(file.names)){
  file <- read_comparison_from_blast(file.names[i])
  file <- reverse(file)
  comps[[j]] <- file
  j <- j+1
}

color1<-"#1b9e77ff"
color2<-"#d95f02ff"
color3<-"#66a61eff"
color4<-"#7570b3ff"
color5<-"#e7298aff"
color6<-"#e6ab02ff"


#Custom colors and names corresponding to phylogenetic tree
segs[["00_An-1.gb"]][["fill"]] <- c(color3)
segs[["C24.gb"]][["fill"]] <- c("#1b9e77ff","#e7298aff","#66a61eff")
segs[["Cvi.gb"]][["fill"]] <- c("#1b9e77ff","#d95f02ff","#7570b3ff")
segs[["Eri.gb"]][["fill"]] <- c("#1b9e77ff","#d95f02ff","#7570b3ff")
segs[["Kyo.gb"]][["fill"]] <- c("#1b9e77ff","#e7298aff","#7570b3ff")
segs[["Ler.gb"]][["fill"]] <- c("#1b9e77ff","#e6ab02ff","#66a61eff")
segs[["Sha.gb"]][["fill"]] <- c("#66a61eff","#d95f02ff","#66a61eff")

segs[["00_An-1.gb"]][["name"]] <- c("9079872-9082475")
segs[["C24.gb"]][["name"]] <- c("9130221-2776","9134106-6676","9145050-7620")
segs[["Cvi.gb"]][["name"]] <- c("9120697-2909","9124568-7141","9130714-3320")
segs[["Eri.gb"]][["name"]] <- c("9109510-12023","9113329-5932","9120065-2667")
segs[["Kyo.gb"]][["name"]] <- c("9108630-11143","9112477-5047","9118682-21285")
segs[["Ler.gb"]][["name"]] <- c("9154094-56607","9157941-60511","9165460-68030")
segs[["Sha.gb"]][["name"]] <- c("9123318-5915","9128942-31545","9135188-37758")

segs[["01_TAIR10_2.gb"]][["fill"]] <- c("black","#e7298aff","#d95f02ff","black","#7570b3ff","#66a61eff")
segs[["01_TAIR10_2.gb"]][["name"]] <- c(" ","RLP40","RLP41"," ","RLP42","RLP39")

print("Reading DNAsegs from txt files")
annot1 <- lapply(segs,function(x){
  mid <- middle(x)
  annot <- annotation(x1=mid,text=x$name,rot=0)
})


file <- paste(getwd(),"/","output",".svg", sep='')
message(file)

svg(file)

plot_gene_map(dna_segs=segs, comparisons=comps, annotations=annot1,annotation_height=2)

dev.off()


