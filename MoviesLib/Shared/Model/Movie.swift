//
//  Movie.swift
//  MoviesLib
//
//  Created by Fernando Cesar Martins on 02/09/22.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let categories: String
    let duration: String
    let rating: Double
    let summary: String
    let image: String
    
//    enum CodingKeys: String, CodingKey {
//        case title
//        case categories = "categorias"
//        case duration
//        case rating
//        case movieSummary
//        case image
//    }
}
