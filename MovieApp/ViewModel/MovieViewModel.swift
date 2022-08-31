//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import Foundation

final class MovieViewModel: MovieViewModelProtocol {
    var movieOutPut: MovieProtocol?
    
    func setDelegate(movie: MovieProtocol) {
        movieOutPut = movie
    }
    
    private var isShowing: Bool = false
    
    var movies: [Movie] = []
    
    func getMovies(pagination: Bool, completion: @escaping (String?) -> ()) {
        changeLoading(pagination: pagination)
        
        guard !MovieManager.shared.isPaginating else {
            return
        }
        MovieManager.shared.getMovies(pagination: pagination) { movies, errorMessage in
            if let movies = movies {
                self.changeLoading(pagination: pagination)
                self.movies = movies
                self.movieOutPut?.saveDatas(pagination: pagination, movies: movies)
            }
            completion(errorMessage ?? "")
        }
        
    }
    
    func changeLoading(pagination: Bool) {
        if !pagination {
            isShowing = !isShowing
            movieOutPut?.showIndicator(isShow: isShowing)
        }
    }
}
