//
//  ActivityDetailsView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation
import SwiftUI

// I use view data instead of Activity object because I dont like the fact that the view has to do string parsing / handle nil case etc
// This way I can have a better separation of datas and view, I can be faster to update views if needed
struct ActivityDetailsViewData {
    let status: CallStatusViewData
    let type: String
    let from: String
    let via: String
    let to: String
    let duration: String
    let date: Date
    
    init(activity: Activity) {
        status = CallStatusViewData(activity: activity)
        type = activity.callType == .voicemail ? "Voicemail" : "\(activity.callType.rawValue) call"
        from = "From \(activity.from)"
        via = "Via \(activity.via)"
        to = "To \(activity.to ?? "Unkwown")"
        duration = "\(activity.duration) seconds"
        date = activity.createdAt
    }
}

struct ActivityDetailsView: View {
    @State private var showArchiveConfirmation = false
    @ObservedObject private var viewModel: ActivityDetailsViewModel
    
    
    init(viewModel: ActivityDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            LoadableView(viewModel: viewModel) { activity in
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Spacer()
                        CallStatusView(viewData: activity.status)
                            .font(.largeTitle)
                            .padding()
                            .overlay(
                                Circle().stroke(Color.main, lineWidth: 2)
                            )
                        Spacer()
                        
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        Text("\(activity.type)".uppercased())
                            .font(.title)
                        Spacer()
                        
                    }
                    Divider()
                    dateRow(activity: activity)
                    Divider()
                    callRow(activity: activity)
                    Divider()
                    ActionButton(title: "Archive", image: "archivebox.fill", onSelect: {
                        showArchiveConfirmation.toggle()
                    })
                }
                .padding()
                .font(.body)
                Spacer()
                ConfirmArchiveView(isPresented: $showArchiveConfirmation, id: .constant(viewModel.id), viewModel: .init(apiManager: viewModel.apiManager), onFinish: {
                    //todo
                })
            }
        }
    }
    
    private func dateRow(activity: ActivityDetailsViewData) -> some View {
        return VStack(alignment: .leading) {
            Text(activity.date, style: .date)
            Text(activity.date, style: .time)
            Text(activity.duration)
                .foregroundColor(.gray)
        }
    }
    
    private func callRow(activity: ActivityDetailsViewData) -> some View {
        return VStack(alignment: .leading) {
            Text(activity.from)
            Text(activity.to)
            Text(activity.via)
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ActivityDetailsViewModel(apiManager: MockApiManager(), id: 0)
        ActivityDetailsView(viewModel: viewModel)
    }
}
