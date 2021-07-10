//
//  AircallTestApp.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import SwiftUI

@main
struct AircallTestApp: App {
    init() {
        /// Configure nav bar appearance for better UI
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(Color.main)
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = ActivitiesViewModel(apiManager: ApiManager())
            ActivitiesView(viewModel: viewModel)
        }
    }
}
