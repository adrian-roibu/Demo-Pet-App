//
//  Photo.swift
//  Demo Pet App
//
//  Created by Adrian Roibu on 29.02.2024.
//

import Foundation

struct Photo: Decodable, Hashable {
    let full: String
    
    var fullURL: URL? {
        return URL(string: full)
    }
}
