//
//  MoviewModel.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import Foundation

// MARK: - MovieModelElement
struct MovieModelElement: Codable {
    var id: Int?
    var title: String?
    var year: Int?
    var genre: [String]?
    var rating: Double?
    var director: String?
    var actors: [String]?
    var plot: String?
    var poster: String?
    var trailer: String?
    var runtime: Int?
    var awards, country, language, boxOffice: String?
    var production: String?
    var website: String?
}
