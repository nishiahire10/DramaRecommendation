//
//  RecommendationsViewModel.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation
import Combine

class RecommendationsViewModel : ObservableObject {
    @Published var recommendationData : [Recommendations] = []
    @Published var errorMessage : String?
    @Published var isLoading : Bool = false
    var cancellables = Set<AnyCancellable>()
    private let networkService: RecommendationNetworkServiceProtocol
    
    init(networkService: RecommendationNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getRecommendationData(_ category : String) {
        isLoading = true
        networkService.getRecommendationData(category)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    if let decodingError = error as? DecodingError {
                        self?.errorMessage = ErrorHandler().handleError(error: decodingError)
                    } else {
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }, receiveValue: { [weak self] recommendations in
                self?.recommendationData = recommendations
            })
            .store(in: &cancellables)
    }
}
