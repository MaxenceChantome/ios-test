//
//  ActivitiesViewModel.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation


class ActivitiesViewModel: ObservableObject {
    let apiManager: ApiManagerRoutes
    
    @Published var state: State<Activities> = .idle
    
    required init(apiManager: ApiManagerRoutes) {
        self.apiManager = apiManager
    }
    
    func load() {
        state = .loading
        apiManager.getActivities { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let activities):
                self.state = .loaded(activities)
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
}
