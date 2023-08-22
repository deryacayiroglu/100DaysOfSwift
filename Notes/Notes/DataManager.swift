//
//  DataManager.swift
//  Notes
//
//  Created by Derya Çayıroğlu on 22.08.2023.
//

import Foundation

struct DataManager {
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedNotes")
    
    static func load() -> [Note] {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Note].self, from: data) {
                return decoded
            }
        }
        print("no data to load")
        return []
    }
    
    static func save(_ notes: [Note]) {
        if let data = try? JSONEncoder().encode(notes) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
