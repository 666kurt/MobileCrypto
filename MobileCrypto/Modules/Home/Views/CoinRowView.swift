//
//  CoinRowView.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 09.07.2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
                .padding(.leading, 6)
        }
    }
    
    private var centerColumn: some View {
        VStack(spacing: 0) {
            VStack(alignment: .trailing) {
                Text(coin.currentHoldingPrice.asCurrencyWith6Decimal())
                    .bold()
                Text((coin.currentHoldings ?? 0).asStringNumber())
            }
            .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimal())
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0%")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0
                    ? Color.theme.green
                    : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
}

#Preview {
    CoinRowView(coin: DeveloperPreview.shared.coin, showHoldingColumn: true)
}
