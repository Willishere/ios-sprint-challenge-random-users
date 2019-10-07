//
//  Results.swift
//  Random Users
//
//  Created by William Chen on 10/6/19.
//  Copyright © 2019 Erica Sadun. All rights reserved.
//

import Foundation

struct Results: Codable {
    var results: [UsersPhotoReference]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([UsersPhotoReference].self, forKey: .results)
    }
}
