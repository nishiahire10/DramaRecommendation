//
//  WebService.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation
import Combine

protocol RecommendationNetworkServiceProtocol : AnyObject {
    func getRecommendationData() -> AnyPublisher<[Recommendations],Error>
}

protocol ReviewsNetworkServiceProtocol : AnyObject {
    func getReviewsData() -> AnyPublisher<[Reviews],Error>
}

