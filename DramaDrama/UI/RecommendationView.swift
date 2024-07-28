//
//  RecommendationView.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import SwiftUI

struct RecommendationView: View {
    @State private var selectedSegment = 0
    @ObservedObject var viewModel : RecommendationsViewModel
    @State var category : String = "recent"
    let segments = ["Recent", "Shows", "Movies"]

    init(viewModel: RecommendationsViewModel = RecommendationsViewModel(networkService: RecommendationWebService())) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            VStack {
                Picker("Category", selection: $selectedSegment) {
                    ForEach(0..<3) { index in
                        Text(segments[index]).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: selectedSegment) { newValue in
                    updateCategory()
                    viewModel.getRecommendationData(category)
                }
                ZStack {
                    if viewModel.isLoading == true {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Center the ProgressView

                    } else {
                        List(viewModel.recommendationData, id: \.id) { recommendation in
                            DramaCellView(urlstr: recommendation.recommendation.poster_url, titleStr: recommendation.recommendation.title)
                        }
                    }
                }
            }
            .padding(.top,0)
            .navigationBarTitle("Drama")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getRecommendationData(category)
            }
    }
    
    
    func updateCategory() {
        switch selectedSegment {
        case 0:
            category = "recent"
        case 1:
            category = "shows"
        case 2:
            category = "movies"
        default:
            category = "recent"
        }
    }
}

struct RecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationView()
    }
}
