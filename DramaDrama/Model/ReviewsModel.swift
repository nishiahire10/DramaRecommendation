//
//  ReviewsModel.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation

struct Reviews : Codable, Identifiable {
    var id: UUID = UUID()
    var item : ReviewsItem?
    var user : User?
    var helpful_votes : Int
    var title : String?
    var text : String?
    var rating : Rating?
    
    enum CodingKeys : CodingKey {
        case item, user, helpful_votes, title, text, rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.item = try container.decode(ReviewsItem.self, forKey: .item)
        self.user = try container.decode(User.self, forKey: .user)
        self.helpful_votes = try container.decode(Int.self, forKey: .helpful_votes)
        self.title = try container.decode(String?.self, forKey: .title)
        self.text = try container.decode(String.self, forKey: .text)
        self.rating = try container.decode(Rating.self, forKey: .rating)
    }
}

struct ReviewsItem : Codable {
    var title : String?
    var mdl_id : String?
    var poster_url : String?
    var status : String?
}

struct User : Codable {
    var username : String
    var mdl_id : String
}

struct Rating : Codable {
    var overall : Float?
    var story : Float?
    var acting : Float?
    var music : Float?
    var rewatch_value : Float?
}

