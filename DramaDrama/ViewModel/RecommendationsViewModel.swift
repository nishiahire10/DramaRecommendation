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
}
