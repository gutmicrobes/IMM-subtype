
library(ConsensusClusterPlus)        #���ð�
#cellFile="wei143+22+1355.txt"     #���������ļ�
workDir="F:/meng/school/2nd_paper/paper_data/2022.8.24/ɸѡ΢����NA/colon2"     #����Ŀ¼
setwd(workDir)       #���ù���Ŀ¼

#��ȡ�����ļ�
#data=read.table(cellFile, header=T, sep="\t", check.names=F, row.names=1)
data = read.csv("./newdata_13+22+44.csv",header = T,check.names=F, row.names=1)
data1=scale(data,center = TRUE, scale = TRUE)   #��׼��
data1[is.na(data1)] <- 0 
data=t(data1)


#����
maxK=9
results=ConsensusClusterPlus(data,
              maxK=maxK,
              reps=50,
              pItem=0.8,
              pFeature=1,
              title=workDir,
              clusterAlg="km",
              distance="euclidean",
              seed=123456,
              plot="png")


#������
clusterNum=2        #�ּ��࣬�����жϱ�׼�ж�
cluster=results[[clusterNum]][["consensusClass"]]
write.table(cluster,file="ICIcluster2.txt",sep="\t",quote=F,col.names=F)


library(survival)
library(survminer)
clusterFile="ICIcluster2_new.txt"     #���߾����ļ�
cliFile="202_Cli_modify0.csv"               #���������ļ�
setwd("F:\\meng\\school\\2nd_paper\\paper_data\\2022.7.1\\colon134+rectum18")      #���ù���Ŀ¼

#��ȡ�����ļ�
cluster=read.table(clusterFile, header=F, sep="\t", check.names=F, row.names=1)
rownames(cluster)=gsub("(.*?)\\_(.*?)", "\\2", rownames(cluster))
cli=read.table(cliFile, header=T, sep=",", check.names=F, row.names=1)
colnames(cli)=c("age","futime","sex","site","fustat")
cli[,c(2)]<-as.numeric(unlist(cli[,c(2)]),na.rm=T)
cli$futime=cli$futime/12

#���ݺϲ�
sameSample=intersect(row.names(cluster), row.names(cli))
rt=cbind(cli[sameSample,], ICIcluster=cluster[sameSample,])
letter=c("A","B","C","D","E","F","G")
uniqClu=levels(factor(rt$ICIcluster))
rt$ICIcluster=letter[match(rt$ICIcluster, uniqClu)]


#������
fit.all<-coxph(Surv(futime,fustat)~ ICIcluster ,data=rt)
summary(fit.all)


#�������ͳ��
fit.all<-coxph(Surv(futime,fustat)~ age+sex+site+ICIcluster,data=rt)
summary(fit.all)


modaldata <- with(rt,
                  data.frame(
                    ICIcluster = levels(factor(rt$ICIcluster)), 
                    sex = rep("Female",2),
                    age = rep (mean(age,na.rm=TRUE), 2),
                    site = rep("Colon",2) )
)

modaldata <- with(rt,
                  data.frame(
                    ICIcluster = levels(factor(rt$ICIcluster)), 
                    #T = rep("0", 3),#c(0,0),
                    #N = rep("0", 3),#c(0,0),
                    sex = rep("0", 3),
                    race = rep("0", 3),
                    #stage = rep("1", 3),
                    age = rep (mean(age,na.rm=TRUE), 3),
                    site = rep("0", 3))#c(0,0) )
)

length=length(levels(factor(rt$ICIcluster)))
diff=survdiff(Surv(futime, fustat) ~ ICIcluster, data = rt)
pValue=1-pchisq(diff$chisq, df=length-1)
if(pValue<0.00001){
  pValue="p<0.00001"
}else{
  pValue=paste0("p=",sprintf("%.03f",pValue))
}


survplots <- survfit(fit.all , newdata = modaldata )
surPlot=ggsurvplot(survplots, 
                   data=modaldata,
                   conf.int=F,
                   #pval=pValue,
                   #pval.size=6,
                   legend.title="ICI cluster",
                   legend.labs=levels(factor(rt[,"ICIcluster"])),
                   legend = c(0.8, 0.8),
                   font.legend=10,
                   xlab="Time(years)",
                   ylab = " Survival Probability "
                   )
print(surPlot)

plot(survplots, xlab = "Years",
     ylab = "Survival Probability", col = 2:5)
#legend("bottomleft", title="ICI Cluster",c("1","2"), col = 2:5, lty = 1)
legend("bottomleft", title="ICI Cluster",levels(factor(rt$ICIcluster)), col = 2:5, lty = 1)
legend("topright", title="HR=1.8497", col = 2:5, lty = 1)

#HR=1.8497          2��
#HR=1.4224         3��
