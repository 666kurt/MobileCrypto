//
//  NetworkManager.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 09.07.2024.
//

import Foundation
import Combine

class NetworkManager {
    
    enum NetworkErrors: LocalizedError {
        case badURLResponce(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponce(url: let url): return "Bad URL adress with \(url)"
            case .unknown: return "Unknown error"
            }
        }
    }
    
    static func loadData(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponce(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponce(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let responce = output.response as? HTTPURLResponse,
              responce.statusCode >= 200 && responce.statusCode < 300 else {
            throw NetworkErrors.badURLResponce(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished: break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
