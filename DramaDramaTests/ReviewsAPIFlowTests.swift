//
//  ReviewsAPIFlowTests.swift
//  DramaDramaTests
//
//  Created by Nishigandha Bhushan Jadhav on 27/07/24.
//

import XCTest
import Combine
@testable import DramaDrama

class ReviewsMockRecommendation : ReviewsNetworkServiceProtocol {
    var result : Result<[Reviews], Error>?
    
    func getReviewsData(_ category: String) -> AnyPublisher<[DramaDrama.Reviews], Error> {
        if let result = result {
            return result.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
        }
    }
}

final class ReviewAPIFlowTests : XCTestCase {
    var viewModel : ReviewsViewModel!
    var mockService : ReviewsMockRecommendation!
    private var cancellables: Set<AnyCancellable>!

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockService = ReviewsMockRecommendation()
        viewModel = ReviewsViewModel(networkService: mockService)
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
        let reviews = [Reviews(item: ReviewsItem(), user: User(username: "abc", mdl_id: ""), helpful_votes: 3, title: "sDF", text: "dsf", rating: Rating())]
            mockService.result = .success(reviews)
            
            // When
            viewModel.getReviewsData("recent")
            
            // Then
            XCTAssertTrue(viewModel.isLoading)
            
            viewModel.$reviewsData
                .dropFirst()
                .sink { data in
                    XCTAssertEqual(data.first?.item, reviews.first?.item)
                }
                .store(in: &cancellables)
        }
    
    func test_GetRecommendationError() {
        let error = NetworkError.responseError
        mockService.result = .failure(error)
        

        viewModel.getReviewsData("recent")
        XCTAssertTrue(viewModel.isLoading)

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, NetworkError.responseError.localizedDescription)
            }
            .store(in: &cancellables)
        
    }

}
