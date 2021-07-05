//
//  ActivitiesViewModel.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

class ActivitiesViewModel: ObservableObject {
    private let apiManager: ApiManagerRoutes

    @Published var activities = Activities()
    
    init(apiManager: ApiManagerRoutes) {
        self.apiManager = apiManager
        
        apiManager.getActivities { response in
            switch response {
            case .success(let activities):
                print("api success: \(activities)")
                self.activities = activities
            case .failure(let error):
                print("api error: \(error)")
            }
        }
    }
}
