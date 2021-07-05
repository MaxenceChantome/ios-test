//
//  ActivitiesView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import SwiftUI

struct RepositoryListView : View {
    @ObservedObject var viewModel: ActivitiesViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.activities) { activity in
                    ActivityRow(activity: activity)
                }
            }
            .navigationBarTitle(Text("History"))
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ActivitiesViewModel(apiManager: MockApiManager())
        RepositoryListView(viewModel: viewModel)
    }
}
