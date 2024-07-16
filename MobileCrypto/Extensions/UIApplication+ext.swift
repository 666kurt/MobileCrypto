//
//  UIApplication+ext.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 16.07.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    // Метод для закрытия клавиатуры
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
