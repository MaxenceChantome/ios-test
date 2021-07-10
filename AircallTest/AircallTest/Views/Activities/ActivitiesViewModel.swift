//
//  ActivitiesViewModel.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

protocol ActivitiesViewModelType: LoadableViewModelType {
    init(apiManager: ApiManagerRoutes)
    
    var apiManager: ApiManagerRoutes { get }
}

class ActivitiesViewModel:  ActivitiesViewModelType {
    let apiManager: ApiManagerRoutes
    
    @Published var state: LoadingState<[ActivityRowViewData]> = .idle
    
    required init(apiManager: ApiManagerRoutes) {
        self.apiManager = apiManager
    }
    
    func load() {
        state = .loading
        apiManager.getActivities { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let activities):
                let viewData = activities
                    .filter { !$0.isArchived }
                    .map { ActivityRowViewData(activity: $0) }
                self.state = .loaded(viewData)
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
}
