//
//  ReviewsModel.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation

struct Reviews : Codable {
    var item : ReviewsItem
    var user : User
    var helpful_votes : Int
    var title : String
    var text : String
    var rating : Rating
}

struct ReviewsItem : Codable {
    var title : String
    var mdl_id : String
    var poster_url : String
    var status : String
}

struct User : Codable {
    var username : String
    var mdl_id : String
}

struct Rating : Codable {
    var overall : Float
    var story : Int
    var acting : Int
    var music : Int
    var rewatch_value : Int
}

