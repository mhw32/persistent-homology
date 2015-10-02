# Functionalize distances w/ known parameters.

# Calculate the bottleneck distance.
bottleneckDist <- function(X, Y, dimension=1) {
  d <- bottleneck(X, Y, dimension=dimension)
  return(d)
}

# Calculate the 2-power wasserstein distance.
wassersteinDist <- function(X, Y, dimension=1, p=2) {
  d <- wasserstein(X, Y, p=p, dimension=dimension)
  return(d)
}