//
//  WebService.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation
import Combine

protocol RecommendationNetworkServiceProtocol : AnyObject {
    func getRecommendationData(_ category: String)
}

protocol ReviewsNetworkServiceProtocol : AnyObject {
    func getReviewsData(_ category: String)
}

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
