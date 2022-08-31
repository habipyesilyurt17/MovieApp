//
//  MovieViewModelProtocol.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import Foundation

protocol MovieViewModelProtocol {
    var movies: [Movie] { get set }
    func getMovies(pagination: Bool, completion: @escaping (String?) -> ())
    func changeLoading(pagination: Bool)
    
    var movieOutPut: MovieProtocol? { get }
    func setDelegate(movie: MovieProtocol)
}
