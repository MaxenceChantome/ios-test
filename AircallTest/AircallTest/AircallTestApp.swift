//
//  AircallTestApp.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import SwiftUI

@main
struct AircallTestApp: App {
    private let apiManager: ApiManagerRoutes
    
    init() {
        self.apiManager = ApiManager()
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = ActivitiesViewModel(apiManager: apiManager)
            RepositoryListView(viewModel: viewModel)
        }
    }
}
