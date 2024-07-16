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
    
    private let fileManager = LocalFileManager.instance
    private let folderName: String = "coin_images"
    private let imageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getImage()
    }
    
    private func getImage() {
        if let savedImages = fileManager.getImage(folderName: folderName, imageName: imageName) {
            coinImage = savedImages
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.loadData(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.coinImage = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage,
                                           folderName: self.folderName,
                                           imageName: self.imageName)
            })
    }
}
