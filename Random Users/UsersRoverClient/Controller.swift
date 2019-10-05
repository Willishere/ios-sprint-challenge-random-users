//
//  Controller.swift
//  Random Users
//
//  Created by William Chen on 10/5/19.
//  Copyright © 2019 Erica Sadun. All rights reserved.
//

import Foundation

class UserController{
    
        let baseURL = URL(string: "https://randomuser.me/api/")!
    
    func fetchUsersPhotos(using session: URLSession = URLSession.shared, completion: @escaping ([UsersPhotoReference]?, Error?) -> Void) {
        
        let url = self.url(forInfoForUser: "1000")
        print(url.absoluteURL)
        fetch(from: url, using: session) { ( users: [UsersPhotoReference]?, error: Error?) in
            guard let users = users else {
                completion(nil, error)
                return
            }
            completion(users, nil)
        }
    }
    
    private func url(forInfoForUser queryItems: String) -> URL {
        let url = baseURL
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "results", value: queryItems)]
        return urlComponents.url!
    }
    
    private func fetch<T: Codable>(from url: URL,
                              using session: URLSession = URLSession.shared,
                              completion: @escaping (T?, Error?) -> Void) {
           session.dataTask(with: url) { (data, response, error) in
               if let error = error {
                   completion(nil, error)
                   return
               }
               
               guard let data = data else {
                   completion(nil, NSError(domain: "com.LambdaSchool.Random/Users.ErrorDomain", code: -1, userInfo: nil))
                   return
               }
               
               do {
                 let jsonDecoder = JSONDecoder()
                   let decodedObject = try jsonDecoder.decode(T.self, from: data)
                   completion(decodedObject, nil)
               } catch {
                   completion(nil, error)
               }
           }.resume()
       }
    
}
