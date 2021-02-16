//
//  APIManager.swift
//  BreakingBadApp
//
//  Created by Stefan Minchevski on 10/12/20.
//

import UIKit
import Alamofire

class APIManager {

    static let shared = APIManager()
    private init() {}
    
    func getCharacters(completion: @escaping (_ characters: [Character], _ error: Error?) -> Void) {
        let urlString = BASE_URL + "characters"
        guard let url = URL(string: urlString)
        else {
            return completion([], nil)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url).validate().responseDecodable(of: [Character].self, decoder: decoder) { (dataResponse) in
            switch dataResponse.result {
            case .success(let characters):
                completion(characters, nil)
            case .failure(let error):
                completion([], error)
            }
        }.resume()
        

//    func getQuotes(completion: @escaping (_ quote: [Character], _ error: Error?) -> Void) {
//        let urlString = BASE_URL + "quotes"
//        guard let url = URL(string: urlString)
//        else {
//            return completion([], nil)
//        }
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        AF.request(url).validate().responseDecodable(of: [Character].self, decoder: decoder) { (dataResponse) in
//            switch dataResponse.result {
//            case .success(let characters):
//                completion(characters, nil)
//            case .failure(let error):
//                completion([], error)
//            }
//        }.resume()
//     }
//   }
    }
}
