//
//  CircleButtonView.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 08.07.2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25),
                    radius: 10, x: 0, y: 0)
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(imageName: "heart.fill")
}
