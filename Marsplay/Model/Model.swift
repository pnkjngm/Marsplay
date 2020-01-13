//
//  Model.swift
//  Marsplay
//
//  Created by Pankaj Kumar Nigam on 10/01/20.
//  Copyright © 2020 Pankaj Kumar Nigam. All rights reserved.
//

import Foundation

class NetworkServer {
    
    func apiCall(page: Int, completion: @escaping (_ jsonObject: Search?, _ error: Error?) -> Void) {

        guard page < 11 else { return }
        let url = URL(string: "http://www.omdbapi.com/?s=Batman&page=\(page)&apikey=eeefc96f")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, err) in
            
            guard err == nil else {
                print("Something Went Wrong with API Call")
                return completion(nil, err)
            }
            guard let data = data else { return completion(nil, err)}
            do {
                let decodedObject = try JSONDecoder().decode(Search.self, from: data)
                return completion(decodedObject, nil)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
}

struct Search : Decodable {
    
    let Search : [MovieInfo]
    let totalResults: String
    let Response: String
    
    enum codingKeys: String, CodingKey {
        case totaResults
        case search = "Search"
        case response = "Response"
    }
    
}

struct MovieInfo : Codable {

    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        
        case imdbID
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
    
    init(title: String, year: String, type: String, imdbID: String, poster: String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}
