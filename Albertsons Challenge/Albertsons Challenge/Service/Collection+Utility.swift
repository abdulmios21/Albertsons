//
//  Collection+Utility.swift
//  Albertsons Challenge
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
