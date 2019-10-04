//
//  MarsPhotoReference.swift
//  Random Users
//
//  Created by William Chen on 10/4/19.
//  Copyright © 2019 Erica Sadun. All rights reserved.
//

import Foundation

struct UsersPhotoReference: Codable {
    let results: [String]
    let picture: URL
    
    enum ResultsKey: String, CodingKey {
        case results
        case picture
        
        enum MainKey: String, CodingKey {
            case name
            case id
            case picture
            
            
            enum NameKey: String, CodingKey{
                case title
                case first
                case last
                
            }
            
            enum IdKey: String, CodingKey {
                case value
                
            }
            
            enum PictureKey: String, CodingKey {
                case large
            }
        }
    }
    
    
    
}
 
