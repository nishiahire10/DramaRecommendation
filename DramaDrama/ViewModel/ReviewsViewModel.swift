//
//  ReviewsViewModel.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation
import Combine



class ReviewsViewModel : ObservableObject {
    @Published var reviewsData : [Reviews] = []
    @Published var errorMessage : String?
    var cancellables = Set<AnyCancellable>()
}

extension ReviewsViewModel : ReviewsNetworkServiceProtocol {
    func getReviewsData(_ category : String) {
        guard let url = URL(string: "https://mydramalist.p.rapidapi.com/reviews?category=\(category)") else {
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
        
        session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.responseError
                }
                return output.data
            }
            .decode(type: [Reviews].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
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
                self.reviewsData = reviews

            })
            .store(in: &cancellables)
        
    }
}
