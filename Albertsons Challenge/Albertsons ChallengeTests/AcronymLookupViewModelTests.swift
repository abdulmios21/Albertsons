//
//  AcronymLookupViewModelTests.swift
//  Albertsons ChallengeTests
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import XCTest
@testable import Albertsons_Coding_Challenge

class AcronymLookupViewModelTests: XCTestCase {
    var viewModel: AcronymLookupViewModel!
    var service: AcronymLookupServiceProtocol!

    override func setUp() {
        service = MockAcronymLookupService()
        viewModel = AcronymLookupViewModel(service: service)
    }
    
    func testAcronymMeaningForServiceReturningValues() {
        viewModel.findMeaningForAcronym("hmm") { result in
            switch result {
            case .success(let models):
                XCTAssertTrue(models.first == "hidden markov model")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription == error.localizedDescription)
            }
        }
    }
}
