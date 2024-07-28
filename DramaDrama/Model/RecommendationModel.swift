//
//  RecommendationModel.swift
//  DramaDrama
//
//  Created by Nishigandha Bhushan Jadhav on 25/07/24.
//

import Foundation

struct Recommendations : Codable, Identifiable, Equatable {
    static func == (lhs: Recommendations, rhs: Recommendations) -> Bool {
        lhs.recommendation == rhs.recommendation
    }
    
    var id = UUID()
    var user : User
    var text : String
    var likes : Int
    var date : String
    var if_you_liked : DramaOrMovie
    var recommendation : DramaOrMovie
     
    enum CodingKeys : CodingKey {
        case user, text, likes, date, if_you_liked, recommendation
    }
    
    init(user: User, text: String, likes: Int, date: String, if_you_liked: DramaOrMovie, recommendation: DramaOrMovie) {
        self.user = user
        self.text = text
        self.likes = likes
        self.date = date
        self.if_you_liked = if_you_liked
        self.recommendation = recommendation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
        self.text = try container.decode(String.self, forKey: .text)
        self.likes = try container.decode(Int.self, forKey: .likes)
        self.date = try container.decode(String.self, forKey: .date)
        self.if_you_liked = try container.decode(DramaOrMovie.self, forKey: .if_you_liked)
        self.recommendation = try container.decode(DramaOrMovie.self, forKey: .recommendation)
    }
    
}

struct DramaOrMovie : Codable, Equatable {
    var title : String
    var mdl_id : String
    var poster_url : String
}

