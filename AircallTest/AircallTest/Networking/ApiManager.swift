//
//  ApiManager.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation
import Combine

protocol ApiManagerRoutes {
    func getActivities(completion: @escaping(Result<Activities, Error>) -> Void)
    func getActivity(id: Int, completion: @escaping(Result<Activity, Error>) -> Void)
    func archiveActivity(id: Int, completion: @escaping(Result<ApiResponse, Error>) -> Void)
    func resetActivitiescompletion(completion: @escaping(Result<ApiResponse, Error>) -> Void)
}

class ApiManager: ApiManagerRoutes {
    private typealias Parameters = [String: Any]
    private let baseUrl = "aircall-job.herokuapp.com"
    private var subscriber = Set<AnyCancellable>()
    
    func getActivities(completion: @escaping(Result<Activities, Error>) -> Void) {
        get(endpoint: .activities, completion: completion)
    }
    
    func getActivity(id: Int, completion: @escaping(Result<Activity, Error>) -> Void) {
        let endoint = ApiEndpoints.activity(id: id)
        get(endpoint: endoint, completion: completion)
    }
    
    func archiveActivity(id: Int, completion: @escaping (Result<ApiResponse, Error>) -> Void) {
    }
    
    
    func resetActivitiescompletion(completion: @escaping(Result<ApiResponse, Error>) -> Void) {
    }
}

extension ApiManager {
    private func get<T: Codable>(endpoint: ApiEndpoints, parameters: Parameters? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: "https://\(baseUrl)\(endpoint.path)")!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { result in
                completion(.success(result))
            }
            .store(in: &subscriber)
    }
}
