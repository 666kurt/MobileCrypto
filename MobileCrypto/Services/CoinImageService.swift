//
//  CoinImageService.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 10.07.2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var coinImage: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getImage()
    }
    
    private func getImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.loadData(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.coinImage = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
