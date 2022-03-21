//
//  Service.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/21.
//

import Foundation

class Service {
    static let shared = Service()
    
    func search(term: String, completion: @escaping(SearchResultDTO?, Error?) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(term)&entity=software&country=KR"
        
        fetchResult(url: url, completion: completion)
    }
    
    private func fetchResult<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> Void) {
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        let configure = URLSessionConfiguration.default
        let session = URLSession(configuration: configure)
        print(url)
        session.dataTask(with: url) { data, response, error in
            print("cc")
            guard error == nil else {
                print(error)
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
//            print("bb")
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
