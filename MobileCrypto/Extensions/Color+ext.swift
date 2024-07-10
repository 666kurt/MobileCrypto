//
//  Color+ext.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 08.07.2024.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    static let theme = ColorData()
}

struct ColorData {
    let accent = Color("accentColor")
    let background = Color("backgroundColor")
    let red = Color("redColor")
    let green = Color("greenColor")
    let secondaryText = Color("secondaryTextColor")
}
