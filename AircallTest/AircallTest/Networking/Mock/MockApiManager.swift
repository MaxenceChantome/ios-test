//
//  MockApiManager.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

class MockApiManager: ApiManagerRoutes {
    func getActivities(completion: @escaping(Result<Activities, Error>) -> Void) {
        get(endpoint: .activities) { response in
            completion(response)
        }
    }
    
    func getActivity(id: String, completion: @escaping(Result<Activity, Error>) -> Void) {
    }
    
    func archiveActivity(id: String, completion: @escaping (Result<ApiResponse, Error>) -> Void) {
    }
    
    
    func resetActivitiescompletion(completion: @escaping(Result<ApiResponse, Error>) -> Void) {
    }
}

extension MockApiManager {
    /// Get object from a mock JSON file
    private func get<T: Decodable>(endpoint: ApiEndpoints, completion: @escaping (Result<T, Error>) -> Void) {
        let filename = endpoint.mockFilename
        
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            } catch let err {
                completion(.failure(err))
            }
        } else {
            let error = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Cant find file \(filename)"])
            completion(.failure(error))
        }
    }
}
