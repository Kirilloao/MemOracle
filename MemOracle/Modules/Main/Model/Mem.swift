//
//  Mem.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import Foundation

struct Welcome: Codable {
    let success: Bool
    let data: DataCLass
}

struct DataCLass: Codable {
    let memes: [Meme]
}

struct Meme: Codable {
    let url: String
}
