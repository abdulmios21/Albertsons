//
//  AcronymLookupService.swift
//  Albertsons Challenge
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import Foundation

enum AcronymLookupServiceError: Error {
    case badRequest
    case badData
}

typealias AcronymLookupServiceResult = Result<[AcronymMeaning], Error>

protocol AcronymLookupServiceProtocol {
    func getMeanings(for acronym: String, result: @escaping ((AcronymLookupServiceResult) -> Void))
}

final class AcronymLookupService: AcronymLookupServiceProtocol {
    static let baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    
    func getMeanings(for acronym: String, result: @escaping ((AcronymLookupServiceResult) -> Void)) {
        guard let request = getUrl(for: acronym) else {
            result(.failure(AcronymLookupServiceError.badRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            
            guard let data = data else {
                result(.failure(AcronymLookupServiceError.badData))
                return
            }
            
            do {
                let meaningModels = try JSONDecoder().decode([AcronymMeaning].self, from: data)
                result(.success(meaningModels))
            } catch let error {
                result(.failure(error))
            }
        }
        task.resume()
    }
    
    private func getUrl(for acronym: String) -> URLRequest? {
        let urlString = "\(AcronymLookupService.baseURL)?sf=\(acronym)"
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}
