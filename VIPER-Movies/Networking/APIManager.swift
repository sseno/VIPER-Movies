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
    
    func request<T: Decodable>(httpMethod method: HTTPMethod, baseUrl baseURL: String = APIEnv.baseURL, pathUrl pathURL: String, lastPathUrl: String? = nil, parameters: [String: Any]? = nil, completion: @escaping (Result<T, ErrorAPI>) -> Void) {
        
        var fullURL = baseURL + pathURL + "?api_key=\(APIEnv.apiKey)"
        if let lastPathUrl = lastPathUrl {
            fullURL.append("&\(lastPathUrl)")
        }
        
        guard let url = URL(string: fullURL) else {
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
            
            print("\nHeaders >>> \(String(describing: request.allHTTPHeaderFields))")
            print("URL Request >>> \(String(describing: url))")
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode >>> \(String(describing: httpResponse.statusCode))\n\n")
            }
            
            print("Param >>> \(String(describing: parameters))")
            print("Response >>> \(data.prettyPrintedJSONString ?? "")\n\n")
            
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

extension Data {
    /// https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        if #available(iOS 11.0, *) {
            guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
                  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]),
                  let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
            return prettyPrintedString
        } else {
            guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
                  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                  let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
            return prettyPrintedString
        }
    }
    
}
