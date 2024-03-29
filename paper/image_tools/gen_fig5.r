# -- Figure 5 : compilation of different tests --

library(TDA)
library(scatterplot3d)

source('../../tools.r')
source('../../Voronoi3Dfct.r')

library(TDA)
library(pracma)

eulerChar <- function(tseq, diagram, maxdimension, threshold=0) {
    eulerFct <- function(t) {
        if (threshold>0) {
            persistence <- diagram[,3]-diagram[,2]
            diagram <- diagram[which(persistence>=threshold),]
        }
        betti <- numeric(maxdimension)
        for (i in 0:maxdimension) {
            betti[i+1]=((-1)^i)*sum(diagram[,1]==i & diagram[,2]<=t & diagram[,3]>t)
        }
        out <- sum(betti)
        return(out)
    }
    out <- numeric(length(tseq))
    count <- 0
    for (t in tseq) {
        count <- count + 1
        out[count] <- eulerFct(t)
    }
    return(out)
}

# a) point cloud

res <- 0.5
perturb <- 1
N <- 10000
boxlim <- c(0, 20)

Xlim <- boxlim
Ylim <- boxlim
Zlim <- boxlim

vf<- voronoi3d(boxlim,
               res,
               perturb,
               Ncells=64,
               N,
               percClutter=0,
               percWall=1-0.02-0.5,
               percFil=0.5,
               percClust=0.02)

# pdf(paste('figure_5_plot.pdf'))
# scatterplot3d(vf,
#               xlab='',
#               ylab='',
#               zlab='',
#               pch='.',
#               color=rgb(0, 0, 0, 0.25),
#               tick.marks=FALSE,
#               label.tick.marks=FALSE)
# dev.off()

# b) persistence diagram
diag <- gridDiag(vf,
                 dtm,
                 lim=cbind(Xlim,Ylim,Zlim),
                 by=res,
                 sublevel=T,
                 printProgress=T,
                 m0=0.001)
diag <- cleanDiag(diag$diagram)
X <- diag

pdf(paste('figure_5_pd.pdf'))
mar.default <- c(5,4,4,2) + 0.1
par(mar = mar.default + c(0, 1, 0, 0))
plot(X[,2],
     X[,3],
     pch = c(X[,1]+1),
     col = c(X[,1]+1),
     xlab = 'Birth',
     ylab = 'Death',
     main = '',
     cex.lab=2.0,
     cex.axis=2.0,
     cex.main=2.0,
     cex.sub=2.0,
     cex=2.0)
abline(a = 0, b = 1)
legend('bottomright',
       c(expression('H'[0]),expression('H'[1]),expression('H'[2])),
       pch = c(1,2,3),
       col = c(1,2,3),
       cex=2.0)
dev.off()

# # c) euler characteristics
# diag <- gridDiag(vf,
#                  dtm,
#                  lim=cbind(Xlim,Ylim,Zlim),
#                  by=res,
#                  sublevel=T,
#                  printProgress=T,
#                  m0=0.001)
# # no removal of extra pt
# diagram <- diag$diagram
# tseq <- seq(min(diagram[,2:3]),
#             max(diagram[,2:3]),
#             length=5000)

# euler <- eulerChar(tseq,
#                    diagram,
#                    maxdimension=max(diagram[,1]),
#                    threshold=0)

# pdf('figure_5_euler.pdf')
# par(mar=c(5,6,4,2))
# plot(euler,
#      type="l",
#      lwd=3,
#      col="cornflowerblue",
#      xlab="Sequence",
#      ylab="EC",
#      cex.lab=2.0,
#      cex.axis=2.0,
#      cex.main=2.0,
#      cex.sub=2.0,
#      cex=2.0)
# dev.off()

# # d) silhouette function
# tseq <- seq(min(diagram[,2:3]),
#             max(diagram[,2:3]),
#             length=1000)

# silh <- silhouette(diagram,
#                    p=1,
#                    dimension=2,
#                    tseq)

# pdf('figure_5_silhouette.pdf')
# par(mar=c(5,6,4,2))
# plot(abs(silh),
#      type="l",
#      lwd=3,
#      col="cornflowerblue",
#      xlab="Sequence",
#      ylab="SIL",
#      cex.lab=2.0,
#      cex.axis=2.0,
#      cex.main=2.0,
#      cex.sub=2.0,
#      cex=2.0)
# dev.off()

