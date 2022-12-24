
#install.packages('e1071')

#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("preprocessCore")


inputFile="uniq.symbol.txt"      #输入文件
setwd("F:\\meng\\school\\2nd_paper\\paper_data\\immune_cell\\gene_expression_fpkm_final")     #设置工作目录
source("ICI12.CIBERSORT.R")      #引用包

#免疫细胞浸润
outTab=CIBERSORT("ref.txt", inputFile, perm=100, QN=TRUE)

#对免疫浸润结果过滤，并且保存免疫细胞浸润结果
outTab=outTab[outTab[,"P-value"]<0.05,]
outTab=as.matrix(outTab[,1:(ncol(outTab)-3)])
outTab=rbind(id=colnames(outTab), outTab)
write.table(outTab, file="CIBERSORT-Results.txt", sep="\t", quote=F, col.names=F)


