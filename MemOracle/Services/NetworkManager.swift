//
//  NetworkManager.swift
//  MemOracle
//
//  Created by Kirill Taraturin on 24.11.2023.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

// MARK: - Link
enum Link: String {
    case api = "https://api.imgflip.com/get_memes"
}

// MARK: - NetworkManager
final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch(with url: String, completion: @escaping (Result<Welcome, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let mem = try JSONDecoder().decode(Welcome.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(mem))
                }
                
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.decodingError))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
