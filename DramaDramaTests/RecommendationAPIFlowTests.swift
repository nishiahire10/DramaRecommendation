//
//  RecommendationAPIFlowTests.swift
//  DramaDramaTests
//
//  Created by Nishigandha Bhushan Jadhav on 27/07/24.
//

import XCTest
import Combine
@testable import DramaDrama


class RecommendationMockRecommendation : RecommendationNetworkServiceProtocol {
    var result : Result<[Recommendations], Error>?
    
    func getRecommendationData(_ category: String) -> AnyPublisher<[DramaDrama.Recommendations], Error> {
        if let result = result {
            return result.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
        }
    }
}

final class RecommendationAPIFlowTests: XCTestCase {
    var viewModel : RecommendationsViewModel!
    var mockService : RecommendationMockRecommendation!
    private var cancellables: Set<AnyCancellable>!

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockService = RecommendationMockRecommendation()
        viewModel = RecommendationsViewModel(networkService: mockService)
        cancellables = []

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockService = nil
        cancellables = nil
    }

    func testGetRecommendationDataSuccess() {
            // Given
        let recommendations = [Recommendations(user : User(username: "abc", mdl_id: "123"), text: "awdad", likes: 2, date: "", if_you_liked : DramaOrMovie(title: "abcd", mdl_id: "ajsdb", poster_url: "https://i.mydramalist.com/jQxY2z_4t.jpg"), recommendation: DramaOrMovie(title: "xyz", mdl_id: "dssd", poster_url: "https://i.mydramalist.com/jQxY2z_4t.jpg"))]
            mockService.result = .success(recommendations)
            
            // When
            viewModel.getRecommendationData("recent")
            
            // Then
            XCTAssertTrue(viewModel.isLoading)
            
            viewModel.$recommendationData
                .dropFirst()
                .sink { data in
                    XCTAssertEqual(data.first?.recommendation, recommendations.first?.recommendation)
                }
                .store(in: &cancellables)
        }
    
    func test_GetRecommendationError() {
        let error = NetworkError.responseError
        mockService.result = .failure(error)
        

        viewModel.getRecommendationData("recent")
        XCTAssertTrue(viewModel.isLoading)

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, NetworkError.responseError.localizedDescription)
            }
            .store(in: &cancellables)
        
    }

}
