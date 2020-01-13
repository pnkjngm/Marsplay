//
//  ViewModel.swift
//  Marsplay
//
//  Created by Pankaj Kumar Nigam on 10/01/20.
//  Copyright © 2020 Pankaj Kumar Nigam. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    private let model : MovieInfo
    
    init(title: String, type: String, imdbID: String, year: String, poster: String) {
        self.model = MovieInfo(title: title, year: year, type: type, imdbID: imdbID, poster: poster)
    }
    
    var title : String {
        return model.title
    }
    
    var type : String {
        return model.type
    }
    
    var year : String {
        return model.year
    }
    
    var poster : String {
        return model.poster
    }
    
}
