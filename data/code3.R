######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：biowolf@foxmail.com
######答疑微信: 18520221056

#install.packages("vioplot")

library(vioplot)                                                    #引用包
setwd("F:/meng/school/2nd_paper/paper_data/2022.8.24/cell+gene")          #设置工作目录
normal=69   #70                                               
tumor=84    #83                                               

rt <- read.csv("65+7wei_order_violin.csv",header = T,row.names=1)
#rt=read.table("CIBERSORT.filter.txt",sep="\t",header=T,row.names=1,check.names=F)   #读取输入文件

pdf("vioplot.pdf",height=8,width=15)              #保存图片的文件名称
par(las=1,mar=c(12,6,3,3))
rt <- read.csv("18gene_violin.csv",header = T,row.names=1)
x=c(1:ncol(rt))
y=c(1:ncol(rt))
plot(x,y,
     xlim=c(0,52),ylim=c(min(rt),max(rt)+0.002),  #48
     main="",xlab="", ylab="Expression", #"Fraction",#"Abundance",#"Expression",      
     pch=21,
     col="white",
     xaxt="n")

#对每个免疫细胞循环，绘制vioplot，正常用蓝色表示，肿瘤用红色表示
for(i in 1:ncol(rt)){
  normalData=rt[1:normal,i]
  tumorData=rt[(normal+1):(normal+tumor),i]
  vioplot(normalData,at=3*(i-1),lty=1,add = T,col = 'purple')
  vioplot(tumorData,at=3*(i-1)+1,lty=1,add = T,col = 'orange')
  wilcoxTest=wilcox.test(normalData,tumorData)
  p=round(wilcoxTest$p.value,3)
  mx=max(c(normalData,tumorData))
  #lines(c(x=3*(i-1)+0.2,x=3*(i-1)+0.8),c(mx,mx))
  text(x=3*(i-1)+0.5,y=mx+0.1, labels=ifelse(p<0.001,paste0("p<0.001"),paste0("p=",p)),cex = 0.8)
  text(seq(1,52,3),-0.3,xpd = NA,labels=colnames(rt),cex = 1,srt = 45,pos=2)
}
legend("topright",inset=.01,title="Immune Subtype",
       c("Subtype 1","Subtype 2"),col=c("purple","orange"),fill=c("purple","orange"))

normalData=rt[1:normal,5]
tumorData=rt[(normal+1):(normal+tumor),5]
mx=max(c(normalData,tumorData))
text(x=3*(5-1)+1.1,y=mx-0.033, labels=ifelse(p<0.001,paste0("p<0.001"),paste0("p=",p)),cex = 0.8)

normalData=rt[1:normal,7]
tumorData=rt[(normal+1):(normal+tumor),7]
mx=max(c(normalData,tumorData))
text(x=3*(7-1)+2.2,y=mx-0.12, labels=ifelse(p<0.001,paste0("p<0.001"),paste0("p=",p)),cex = 0.8)

dev.off()

datap <- list()
for(i in 1:ncol(rt)){
  normalData=rt[1:normal,i]
  tumorData=rt[(normal+1):(normal+tumor),i]
  wilcoxTest=wilcox.test(normalData,tumorData)
  p=round(wilcoxTest$p.value,4)
  datap[i] <- p
  write.csv(datap,"pvalue_new.csv",row.names = F)}

