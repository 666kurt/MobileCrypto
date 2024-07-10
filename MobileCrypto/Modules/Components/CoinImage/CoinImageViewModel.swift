//
//  CoinImageViewModel.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 10.07.2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coinImageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        self.isLoading = true
        self.coinImageService = CoinImageService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinImageService.$coinImage
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
    
}
