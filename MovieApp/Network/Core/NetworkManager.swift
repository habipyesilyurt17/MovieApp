//
//  NetworkManager.swift
//  MovieApp
//
//  Created by habip on 28.08.2022.
//

import Foundation
import Alamofire

struct NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(type: T.Type, url: String, method: HTTPMethod, completion: @escaping (Result<T, ErrorTypes>)->()) {
        
        AF.request(url, method: method).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.generalError))
            }
        }
    }
}
