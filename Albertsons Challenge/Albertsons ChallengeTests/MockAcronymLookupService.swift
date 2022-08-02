//
//  MockAcronymLookupService.swift
//  Albertsons ChallengeTests
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import Foundation
@testable import Albertsons_Challenge

final class MockAcronymLookupService: AcronymLookupServiceProtocol {
    func getMeanings(for acronym: String, result: @escaping ((AcronymLookupServiceResult) -> Void)) {
        result(.success([AcronymMeaning(sf: "hmm", lfs: [LongForm(lf: "hidden markov model", freq: 10, since: 1982, vars: nil)])]))
    }
}
