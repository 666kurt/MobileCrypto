//
//  HomeViewModel.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 09.07.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var homeCoinList: [Coin] = []
    @Published var portfolioCoinList: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.homeCoinList.append(DeveloperPreview.shared.coin)
            self.portfolioCoinList.append(DeveloperPreview.shared.coin)
        }
    }
}
