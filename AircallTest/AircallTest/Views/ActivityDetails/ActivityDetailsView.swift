//
//  ActivityDetailsView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation
import SwiftUI

struct ActivityDetailsView: View {
    @ObservedObject var viewModel: ActivityDetailsViewModel
    
    var body: some View {
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
            case .loaded(let activity):
                CallStatus(activity: activity)
                .padding(6)
                .clipShape(Circle())
                           .overlay(Circle().stroke(Color.red, lineWidth: 2))
                
                Text(activity.from)
            }
        }
    }
    
    private func loadData() {
        viewModel.load()
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ActivityDetailsViewModel(apiManager: MockApiManager(), id: 0)
        ActivityDetailsView(viewModel: viewModel)
    }
}
