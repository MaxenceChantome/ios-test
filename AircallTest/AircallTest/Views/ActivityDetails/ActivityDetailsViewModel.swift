//
//  ActivityDetailsViewModel.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 06/07/2021.
//

import Foundation

class ActivityDetailsViewModel: ObservableObject {
    private let apiManager: ApiManagerRoutes
    private let id: Int
    
    @Published var state: State<ActivityDetailsViewData> = .idle
    
    required init(apiManager: ApiManagerRoutes, id: Int) {
        self.apiManager = apiManager
        self.id = id
    }
    
    func load() {
        apiManager.getActivity(id: id) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let activity):
                print(activity)
                let viewData = ActivityDetailsViewData(activity: activity)
                self.state = .loaded(viewData)
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
}
