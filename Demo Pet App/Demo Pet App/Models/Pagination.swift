//
//  Pagination.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 29.02.2024.
//

struct Pagination: Decodable {
    let current_page: Int
    let total_pages: Int
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case current_page
        case total_pages
        case links = "_links"
    }
}
