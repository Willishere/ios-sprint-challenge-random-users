//
//  MarsPhotoReference.swift
//  Random Users
//
//  Created by William Chen on 10/4/19.
//  Copyright © 2019 Erica Sadun. All rights reserved.
//

import Foundation

struct UsersPhotoReference: Codable {
    let name: String
    let picture: URL?
    let email: String
    let phone: String
    
    enum ResultsKey: String, CodingKey {
        case name
        case picture
        case email
        case phone
        
            
            enum NameKey: String, CodingKey{
                case title
                case first
                case last
                
        }
            
            
            enum PictureKey: String, CodingKey {
                case large
                case thumbnail
            }
 
     }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultsKey.self)
        var nameContainer = try container.nestedUnkeyedContainer(forKey: .name)
              let nameContentContainer = try nameContainer.nestedContainer(keyedBy: ResultsKey.NameKey.self)
              let titleNameContainer = try nameContentContainer.nestedContainer(keyedBy: ResultsKey.NameKey.self, forKey: .title)
              let firstNameContainer = try nameContentContainer.nestedContainer(keyedBy: ResultsKey.NameKey.self, forKey: .first)
              let lastNameContainer = try nameContentContainer.nestedContainer(keyedBy: ResultsKey.NameKey.self, forKey: .last)
              
              
              name = "\(titleNameContainer)\t \(firstNameContainer)\t\(lastNameContainer)"
        
        let photo = try container.decode(String.self, forKey: .picture)
        picture = URL(string: photo)
        
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
    }
    
}

struct Users: Codable{
    let results: [UsersPhotoReference]
}
 
