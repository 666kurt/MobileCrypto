//
//  HomeViewModel.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 09.07.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoinList: [Coin] = []
    @Published var portfolioCoinList: [Coin] = []
    
    private let coinService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoinList = returnedCoins
            }
            .store(in: &cancellables)
    }
}
