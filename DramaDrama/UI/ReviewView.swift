//
//  ReviewView.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import SwiftUI

struct ReviewView: View {
    @State private var selectedSegment = 0
    let segments = ["Recent", "Best", "Shows", "Movies"]
    @ObservedObject var viewModel : ReviewsViewModel
    @State var category : String = "recent"
    
    init(viewModel : ReviewsViewModel = ReviewsViewModel(networkService: ReviewsWebService())) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            Picker("Segments", selection: $selectedSegment) {
                ForEach(0..<4) { index in
                    Text(segments[index]).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: selectedSegment) { newValue in
                updateCategory()
                viewModel.getReviewsData(category)
            }
            List(viewModel.reviewsData, id: \.id) { review in
                DramaCellView(urlstr: review.item?.poster_url ?? "", titleStr: review.item?.title ?? "")
            }
        }
        .navigationBarTitle("Drama")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getReviewsData(category)
        }
    }
    
    func updateCategory() {
        switch selectedSegment {
        case 0:
            category = "recent"
        case 1:
            category = "best"
        case 2:
            category = "shows"
        case 3:
            category = "movies"
        default:
            category = "recent"
        }
    }
    
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
