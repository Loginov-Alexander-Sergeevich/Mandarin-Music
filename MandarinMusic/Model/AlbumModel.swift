//
//  AlbumModel.swift
//  MandarinMusic
//
//  Created by Александр Александров on 20.12.2021.
//

import Foundation

// MARK: - Welcome
struct Albums: Codable {
    let results: [ResultsAlbums]?
}

// MARK: - Result
struct ResultsAlbums: Codable {
    let artistName: String?
    let collectionName: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let trackCount: Int?
    let releaseDate: String?
    let collectionId: Int
}
