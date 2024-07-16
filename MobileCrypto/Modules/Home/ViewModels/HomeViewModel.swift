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
    @Published var searchText: String = ""
    
    private let coinService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
       $searchText
            .combineLatest(coinService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoinList = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else { return coins }
        
        let lowerText = text.lowercased()
        
        return coins.filter { (coin) in
            return coin.name.lowercased().contains(lowerText) ||
                    coin.id.lowercased().contains(lowerText) ||
                    coin.symbol.lowercased().contains(lowerText)
        }
    }
}
