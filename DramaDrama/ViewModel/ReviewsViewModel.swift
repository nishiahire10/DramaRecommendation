//
//  ReviewsViewModel.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation

class ReviewsViewModel : ObservableObject {
    @Published var reviewsData : [Reviews] = []
    @Published var errorMessage : String?
}
