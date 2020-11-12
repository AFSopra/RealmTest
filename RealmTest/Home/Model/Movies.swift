//
//  Movies.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import Foundation
import RealmSwift

struct Movies: Codable {
    var moviesList: [Movie]

    enum CodingKeys: String, CodingKey {
        case moviesList = "results"
    }
}

struct Movie: Codable {
    let movieID: Int
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case title = "title"
        case voteAverage = "vote_average"
    }
}

class MovieRealm: Object {
    @objc dynamic var movieID: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var voteAverage: Double = 0.0
}
