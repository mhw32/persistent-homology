library(TDA)

eulerChar <- function(tseq, diagram, maxdimension, threshold=0) {
	eulerFct <- function(t) {
		if (threshold>0){
			persistence <- diagram[,3]-diagram[,2]
			diagram <- diagram[which(persistence>=threshold),]
		}
		betti <- numeric(maxdimension)
		for (i in 0:maxdimension){
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

eulerCharDim <- function(tseq, diagram, which.dim, threshold=0) {
	eulerFct <- function(t) {
		if (threshold>0){
			persistence <- diagram[,3]-diagram[,2]
			diagram <- diagram[which(persistence>=threshold),]
		}
	
		betti <- sum(diagram[,1]==which.dim & diagram[,2]<=t & diagram[,3]>t)
		return(betti)
	}
	out <- numeric(length(tseq))
	count <- 0
	for (t in tseq) {
		count <- count + 1
		out[count] <- eulerFct(t)
	}
	return(out)
}

n <- 50
X <- circleUnif(n)
plot(X)

maxdimension <- 1
maxscale <- 3

Diag <- ripsDiag(X, maxdimension, maxscale, printProgress=T)
diagram <- Diag$d
plot(diagram)

tseq <- seq(attributes(diagram)$scale[1],attributes(diagram)$scale[2],length=1000)
euler <- eulerChar(tseq, diagram, maxdimension=max(diagram[,1]), threshold=0)
plot(tseq, euler, type="l", main="Euler Characteristic")


## KDE
# Generate data from the unit circle, plus clutter noise.
n <- 300
XX <- circleUnif(n)

# Grid limits
Xlim <- c(-1.6,1.6)
Ylim <- c(-1.7,1.7)
lim <- cbind(Xlim,Ylim)
by <- 0.065

#Kernel Density Diagram of the suplevel sets
h <- .3  #bandwidth for the function kde
diagram <-gridDiag(XX, kde, lim, by=by, sublevel=F, printProgress=T, h=h)$diag

plot(diagram)
tseq <- seq(attributes(diagram)$scale[1],attributes(diagram)$scale[2],length=1000)
euler <- eulerChar(tseq, diagram, maxdimension=max(diagram[,1]), threshold=0)
plot(tseq, euler, type="l", main="Euler Characteristic")




