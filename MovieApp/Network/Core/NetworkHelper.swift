//
//  NetworkHelper.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import Foundation

enum HTTPMethods: String {
    case get  = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL  = "Invalid url"
    case generalError = "An error happened"
}

enum MovieEndPoint: String {
    case BASE_URL = "https://api.themoviedb.org/3/"
    case API_URL  = "discover/movie?primary_release_date.gte=2014-09-15&primary_release_date.lte=2014-10-22&"
    case API_KEY  = "api_key=4a9812c2dc890165509d3f857a35e4dc"
}

struct NetworkHelper {
    static let shared = NetworkHelper()
    func servicePath(page: Int) -> String {
        return "\(MovieEndPoint.BASE_URL.rawValue)\(MovieEndPoint.API_URL.rawValue)\(MovieEndPoint.API_KEY.rawValue)&page=\(page)"
    }
}
