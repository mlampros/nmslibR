
# data
#-----

set.seed(1)
x = matrix(runif(1000), nrow = 100, ncol = 10)

x_lst = list(x, x)


# response regression
#--------------------

set.seed(3)
y_reg = runif(100)


# response "binary" classification
#---------------------------------

set.seed(4)
y_BINclass = sample(1:2, 100, replace = T)


# response "multiclass" classification
#-------------------------------------

set.seed(5)
y_MULTIclass = sample(1:3, 100, replace = T)


# data for sparse matrices
#-------------------------

data(ionosphere, package = 'KernelKnn')

X = as.matrix(ionosphere[, -c(1:2, ncol(ionosphere))])
