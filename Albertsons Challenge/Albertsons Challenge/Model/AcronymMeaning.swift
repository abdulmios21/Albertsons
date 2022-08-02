//
//  AcronymMeaning.swift
//  Albertsons Challenge
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import Foundation

struct AcronymMeaning: Codable {
    let sf: String
    let lfs: [LongForm]?
}

struct LongForm: Codable {
    let lf: String
    let freq: Int
    let since: Int
    let vars: [LongForm]?
}
