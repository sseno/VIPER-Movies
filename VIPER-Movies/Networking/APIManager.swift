//
//  APIManager.swift
//  VIPER-Movies
//
//  Created by Seno on 02/06/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorAPI: Error {
    case invalidUrl
    case invalidData
    case transportError(Error)
    case serverError(statusCode: Int)
    case decodingError(Error)
}

class APIManager {
    
    func request<T: Decodable>(httpMethod method: HTTPMethod, baseUrl baseURL: String = APIEnv.baseURL, pathUrl pathURL: String, parameters: [String: Any]? = nil, completion: @escaping (Result<T, ErrorAPI>) -> Void) {
        
        let endpoint = baseURL + pathURL + "?api_key=\(APIEnv.apiKey)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(.transportError(error)))
                } else {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        completion(.success(result))
                    default:
                        completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                    }
                }
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
