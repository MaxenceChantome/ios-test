//
//  ActivityRow.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation
import SwiftUI

// I use view data instead of Activity object because I dont like the fact that the view has to do string parsing / handle nil case etc
// This way I can have a better separation of datas and view, I can be faster to update views if needed
struct ActivityRowViewData: Identifiable {
    let id: Int
    let status: CallStatusViewData
    let day: String
    let hours: String
    let to: String
    let from: String
    
    init(activity: Activity) {
        id = activity.id
        status = CallStatusViewData(activity: activity)
        day = activity.createdAt.string(withFormat: .dayAndMonth)
        hours = activity.createdAt.string(withFormat: .hourAndMinutes)
        to = activity.to ?? "Unkwown"
        from = "From \(activity.from)"
    }
}


struct ActivityRow: View {
    var activity: ActivityRowViewData
    
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
            CallStatusView(viewData: activity.status)
                .font(.title)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(activity.to)
                    .font(.headline)
                Text(activity.from)
                    .font(.subheadline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text(activity.day)
                    .font(.footnote)
                Text(activity.hours)
                    .font(.footnote)
            }
            
            Button(action: {
                print("todo")
            }, label: {
                Image(systemName: "exclamationmark.circle")
                    .font(.title2)
                    .foregroundColor(Color.main)
            })
        }
    }
}

struct ActivityRow_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Activities.mockedData) { activity in
            let viewData = ActivityRowViewData(activity: activity)
            ActivityRow(activity: viewData)
                .previewLayout(.fixed(width: 400, height: 60))
        }
    }
}
