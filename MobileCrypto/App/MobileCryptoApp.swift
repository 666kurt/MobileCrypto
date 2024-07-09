//
//  MobileCryptoApp.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 08.07.2024.
//

import SwiftUI

@main
struct MobileCryptoApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeScreen()
            }
            .environmentObject(vm)
        }
    }
}
