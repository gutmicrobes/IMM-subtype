#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("limma", version = "3.8")

library("limma")
normalCount=4               #������Ʒ��Ŀ
tumorCount=178              #������Ʒ��Ŀ

setwd("C:\\Users\\lexb4\\Desktop\\TCGAimmune\\05.normalize")          #���ù���Ŀ¼
rt=read.table("symbol.txt",sep="\t",header=T,check.names=F)           #��ȡ�ļ�
rt=as.matrix(rt)
rownames(rt)=rt[,1]
exp=rt[,2:ncol(rt)]
dimnames=list(rownames(exp),colnames(exp))
data=matrix(as.numeric(as.matrix(exp)),nrow=nrow(exp),dimnames=dimnames)
data=avereps(data)
data=data[rowMeans(data)>0,]

group=c(rep("normal",normalCount),rep("tumor",tumorCount))
design <- model.matrix(~factor(group))
colnames(design)=levels(factor(group))
rownames(design)=colnames(data)
v <-voom(data, design = design, plot = F, save.plot = F)
out=v$E
out=rbind(ID=colnames(out),out)
write.table(out,file="uniq.symbol.txt",sep="\t",quote=F,col.names=F)        #����ļ�



###Video source: http://study.163.com/u/biowolf
######Video source: https://shop119322454.taobao.com
######�ٿ�����: http://www.biowolf.cn/
######�������䣺2740881706@qq.com
######����΢��: seqBio
######QQȺ:  259208034