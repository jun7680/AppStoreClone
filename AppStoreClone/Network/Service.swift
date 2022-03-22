//
//  Service.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/21.
//

import Foundation

class Service {
    static let shared = Service()
    
    func search(term: String, offset: Int = 0, completion: @escaping(SearchResultDTO?, Error?) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(term)&entity=software&country=KR&offset=\(offset)&limit=50"
        
        fetchResult(url: url, completion: completion)
    }
    
    private func fetchResult<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> Void) {
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        print(url)
        let configure = URLSessionConfiguration.default
        let session = URLSession(configuration: configure)
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
//            let success = 200..<300
//            print("bbvb")
//            print((response as? HTTPURLResponse)?.statusCode)
//            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, success.contains(statusCode) else {
//                return
//
//            }

            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }
            
        }.resume()
        
    }
}
