//
//  MovieProtocol.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import Foundation

protocol MovieProtocol {
    func showIndicator(isShow: Bool)
    func saveDatas(pagination: Bool, movies: [Movie])
}
