//
//  HomeScreen.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 08.07.2024.
//

import SwiftUI

struct HomeScreen: View {
    
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
            }
        }
    }
}

extension HomeScreen {
    var headerView: some View {
        HStack {
            CircleButtonView(imageName: showPortfolio
                             ? "plus"
                             : "info")
            .animation(.none)
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
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
}
