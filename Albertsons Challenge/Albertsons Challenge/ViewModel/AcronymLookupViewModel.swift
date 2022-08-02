//
//  AcronymLookupViewModel.swift
//  Albertsons Challenge
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import Foundation

final class AcronymLookupViewModel {
    private var service: AcronymLookupServiceProtocol
    
    init(service: AcronymLookupServiceProtocol = AcronymLookupService()) {
        self.service = service
    }
    
    func findMeaningForAcronym(_ acronym: String, result: @escaping ((Result<[String], Error>) -> Void)) {
        service.getMeanings(for: acronym) { [weak self] results in
            switch results {
            case .success(let models):
                let meanings = self?.getMeanings(from: models) ?? []
                result(.success(meanings))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    private func getMeanings(from models: [AcronymMeaning]) -> [String] {
        let longForm = models.compactMap({ model in
            model.lfs?.map({ lfs in
                lfs.lf
            })
        })
        
        return longForm.flatMap { $0 }
    }
}
