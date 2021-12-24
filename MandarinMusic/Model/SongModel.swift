//
//  SongModel.swift
//  MandarinMusic
//
//  Created by Александр Александров on 20.12.2021.
//

import Foundation

struct SongsModel: Codable {
    let results: [ResultsSongs]
}

struct ResultsSongs: Codable {
    let trackName: String?
}
