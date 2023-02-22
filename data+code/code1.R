
#install.packages('e1071')

#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("preprocessCore")


inputFile="uniq.symbol.txt"      #�����ļ�
setwd("F:\\meng\\school\\2nd_paper\\paper_data\\immune_cell\\gene_expression_fpkm_final")     #���ù���Ŀ¼
source("ICI12.CIBERSORT.R")      #���ð�

#����ϸ������
outTab=CIBERSORT("ref.txt", inputFile, perm=100, QN=TRUE)

#�����߽��������ˣ����ұ�������ϸ��������
outTab=outTab[outTab[,"P-value"]<0.05,]
outTab=as.matrix(outTab[,1:(ncol(outTab)-3)])
outTab=rbind(id=colnames(outTab), outTab)
write.table(outTab, file="CIBERSORT-Results.txt", sep="\t", quote=F, col.names=F)

