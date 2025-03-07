//
//  CircleButtonAnimationView.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 08.07.2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animated: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 3.0)
            .scale(animated ? 1.0 : 0.0)
            .opacity(animated ? 0.0 : 1.0)
            .animation(animated ? .easeOut(duration: 1.0) : .none, value: animated)
    }
}

#Preview {
    CircleButtonAnimationView(animated: .constant(false))
}
