# include <RcppArmadillo.h>
// [[Rcpp::depends("RcppArmadillo")]]
// [[Rcpp::plugins(openmp)]]
// [[Rcpp::plugins(cpp11)]]

#ifdef _OPENMP
#include <omp.h>
#endif



// return a named Rcpp list for the output list [ NA's if length of knn's not equal for all cases ]
//

// [[Rcpp::export]]
Rcpp::List nmslib_idx_dist(std::vector<std::vector<std::vector<double> > >& input_list, unsigned int k, int threads = 1) {

  #ifdef _OPENMP
  omp_set_num_threads(threads);
  #endif

  unsigned int ROWS = input_list.size();

  arma::mat indices(ROWS, k), distances(ROWS, k);

  indices.fill(arma::datum::nan);

  distances.fill(arma::datum::nan);

  unsigned int i, j;

  #ifdef _OPENMP
  #pragma omp parallel for schedule(static) shared(ROWS, input_list, indices, distances) private(i,j)
  #endif
  for (i = 0; i < ROWS; i++) {

    std::vector<std::vector<double> > inner_vec = input_list[i];

    std::vector<double> inner_idx = inner_vec[0];

    std::vector<double> inner_dist = inner_vec[1];                         // it is possible that the length of a vector differs [ not equal to k -- in that case it takes the value of NA ]

    for (j = 1; j < inner_dist.size(); j++) {                              // indexing of inner vector begins from 1

      #ifdef _OPENMP
      #pragma omp atomic write
      #endif
      indices(i, j-1) = inner_idx[j] + 1;                                  // when populating matrices the indices begin from 0 ALSO add 1 ( + 1) to account for the difference in indexing between C++ and R

      #ifdef _OPENMP
      #pragma omp atomic write
      #endif
      distances(i, j-1) = inner_dist[j];
    }
  }

  return Rcpp::List::create(Rcpp::Named("knn_idx") = indices, Rcpp::Named("knn_dist") = distances);
}



// build matrix from response (y) and output-knn-indices  [ account for the case where an index is NA ]
//

// [[Rcpp::export]]
arma::mat y_idxs(arma::mat& idxs, std::vector<double>& y, int threads = 1) {

  #ifdef _OPENMP
  omp_set_num_threads(threads);
  #endif

  unsigned int NROWS = idxs.n_rows;

  unsigned int NCOLS = idxs.n_cols;

  arma::mat out(NROWS, NCOLS);

  unsigned int i,j;

  #ifdef _OPENMP
  #pragma omp parallel for schedule(static) shared(NROWS, idxs, NCOLS, out, y) private(i,j)
  #endif
  for (i = 0; i < NROWS; i++) {

    for (j = 0; j < NCOLS; j++) {

      if (idxs(i,j) != idxs(i,j)) {                  // if NA append nan-value

        #ifdef _OPENMP
        #pragma omp atomic write
        #endif
        out(i,j) = arma::datum::nan;}

      else {

        #ifdef _OPENMP
        #pragma omp atomic write
        #endif
        out(i,j) = y[idxs(i,j) - 1];                 // account for the difference in indexing betw. R and C++
      }
    }
  }

  return out;
}



// it returns TRUE if the matrix does not include NaN's or +/- Inf
// it returns FALSE if at least one value is NaN or +/- Inf
//

// [[Rcpp::export]]
bool check_NaN_Inf(arma::mat x) {

  return x.is_finite();
}

