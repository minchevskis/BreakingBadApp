//
//  DataManager.swift
//  BreakingBadApp
//
//  Created by Stefan Minchevski on 10/15/20.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {
        characters = []
    }
    
    var characters: [Character]
}
