//
//  WebService.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation
import Combine

enum NetworkError : Error {
    case invalidURL
    case responseError
    case unknown

}

extension NetworkError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}


protocol RecommendationNetworkServiceProtocol : AnyObject {
    func getRecommendationData(_ category: String) -> AnyPublisher<[Recommendations], Error>
}

class RecommendationWebService : RecommendationNetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRecommendationData(_ category: String) -> AnyPublisher<[Recommendations], Error> {
        guard let url = URL(string: "https://mydramalist.p.rapidapi.com/recommendations?category=\(category)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        let headers = [
            "x-rapidapi-key": "e70b710758msh16f592e1ec6c00bp1c1ecdjsn2bf8bc12edac",
            "x-rapidapi-host": "mydramalist.p.rapidapi.com"
        ]
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"

        return session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.responseError
                }
                return output.data
            }
            .decode(type: [Recommendations].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}



