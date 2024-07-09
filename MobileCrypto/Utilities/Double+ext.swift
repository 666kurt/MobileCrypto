//
//  Double+ext.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 09.07.2024.
//

import Foundation

extension Double {

    /// Convent a Double into Currency
    /// ```
    /// Convert 1234.56 -> $1.234,65
    /// Convert 12.3456 -> $12.3465
    /// Convert 0.12345 -> $0.123456
    /// ```
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /// Convent a Double into Currency as String
    /// ```
    /// Convert 1234.56 -> "$1.234,65"
    /// Convert 12.3456 -> "$12.3465"
    /// Convert 0.12345 -> "$0.123456"
    /// ```
    
    func asCurrencyWith6Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
    /// Convent a Double into String representation
    /// ```
    /// Convert 12.3456 -> "12.34"
    /// ```
    
    func asStringNumber() -> String {
        String(format: "%.2f", self)
    }
    
    /// Convent a Double into String representation with percent
    /// ```
    /// Convert 12.3456 -> "12.34%"
    /// ```
    
    func asPercentString() -> String {
        asStringNumber() + "%"
    }
    
    
}
