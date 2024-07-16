//
//  LocalFileManager.swift
//  MobileCrypto
//
//  Created by Максим Шишлов on 16.07.2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage, folderName: String, imageName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard 
            let data = image.pngData(),
            let url = getURLForImage(folderName: folderName, imageName: imageName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image: \(imageName) with \(error)")
        }
    }
    
    func getImage(folderName: String, imageName: String) -> UIImage? {
        guard 
            let url = getURLForImage(folderName: folderName, imageName: imageName),
            FileManager.default.fileExists(atPath: url.path(percentEncoded: true))
        else { return nil }
        return UIImage(contentsOfFile: url.path(percentEncoded: true))
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating folder: \(folderName) with \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(folderName: String, imageName: String) -> URL? {
        guard let url = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return url.appendingPathComponent(imageName + ".png")
    }
    
}
