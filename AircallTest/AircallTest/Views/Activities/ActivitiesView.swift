//
//  ActivitiesView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import SwiftUI

struct ActivitiesView : View {
    @ObservedObject var viewModel: ActivitiesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                switch viewModel.state {
                case .idle:
                    Color.clear.onAppear {
                        loadData()
                    }
                case .loading:
                    ProgressView()
                case .failed( let error):
                    ErrorView(error: error, retry: { loadData() })
                case .loaded(let activities):
                    List(activities) { activity in
                        let detailsViewModel = ActivityDetailsViewModel(apiManager: viewModel.apiManager, id: activity.id)
                        NavigationLink(destination: ActivityDetailsView(viewModel: detailsViewModel)) {
                            ActivityRow(activity: activity)
                        }
                    }
                }
                
            }
            .navigationTitle("History")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func loadData() {
        viewModel.load()
    }
}

struct ActivtiesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ActivitiesViewModel(apiManager: MockApiManager())
        ActivitiesView(viewModel: viewModel)
    }
}
