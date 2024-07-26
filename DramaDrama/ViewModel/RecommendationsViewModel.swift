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
}

extension RecommendationsViewModel : RecommendationNetworkServiceProtocol {
    func getRecommendationData(_ category : String) {
        guard let url = URL(string: "https://mydramalist.p.rapidapi.com/recommendations?category=\(category)") else {
            return
        }
        let headers = [
            "x-rapidapi-key": "10760f8887msh3e5cb3e8501f4ddp120b5djsn8e50ed667682",
            "x-rapidapi-host": "mydramalist.p.rapidapi.com"
        ]
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"

        let session = URLSession.shared
        isLoading = true
        session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.responseError
                }
                return output.data
            }
            .decode(type: [Recommendations].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("Finished successfully")
                case .failure(let error):
                    if let decodingError = error as? DecodingError {
                        self.errorMessage = ErrorHandler().handleError(error: decodingError)
                    } else {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }, receiveValue: { reviews in
                self.recommendationData = reviews

            })
            .store(in: &cancellables)
        
    }
    
   
}
