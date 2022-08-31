//
//  MovieManager.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import Foundation

class MovieManager {
    static let shared = MovieManager()
    var isPaginating: Bool = false
    var moviePage = 1
    func getMovies(pagination: Bool, completion: @escaping ([Movie]?, String?)->()) {
        if pagination {
            moviePage += 1
            isPaginating = true
        }
        
        let url = NetworkHelper.shared.servicePath(page: moviePage)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2)) {
            NetworkManager.shared.request(type: MovieModel.self, url: url, method: .get) { response in
                switch response {
                case .success(let items):
                    completion(items.results, nil)
                    if pagination {
                        self.isPaginating = false
                    }
                case .failure(let error):
                    completion(nil, error.rawValue)
                }
            }
        }
        

    }
}
