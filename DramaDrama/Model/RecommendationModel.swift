//
//  RecommendationModel.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation

struct Recommendations : Codable {
    var user : User
    var text : String
    var likes : Int
    var date : String
    var if_you_liked : DramaOrMovie
}

struct DramaOrMovie : Codable {
    var title : String
    var mdl_id : String
    var poster_url : String
}

