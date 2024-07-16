//
//  HomeScreen.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 08.07.2024.
//

import SwiftUI

// MARK: HomeScreen

struct HomeScreen: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                headerView
                Spacer()
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinList
                        .transition(.move(edge: .leading))
                } else {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

// MARK: Views for HomeScreen

extension HomeScreen {
    
    private var headerView: some View {
        HStack {
            CircleButtonView(imageName: showPortfolio
                             ? "plus"
                             : "info")
            .animation(.none, value: showPortfolio)
            .background(
                CircleButtonAnimationView(animated: $showPortfolio)
            )
            Spacer()
            Text(showPortfolio
                 ? "Show Portfolio"
                 : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(imageName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinList: some View {
        List() {
            ForEach(vm.allCoinList) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinList: some View {
        List() {
            ForEach(vm.portfolioCoinList) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
    
            Text("Prices")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal, 8)
    }
}

// MARK: Preview

#Preview {
    NavigationStack {
        HomeScreen()
            .environmentObject(DeveloperPreview.shared.homeVM)
    }
}
