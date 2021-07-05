//
//  ActivityRow.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation
import SwiftUI

struct ActivityRow: View {
    var activity: Activity
    
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
            
            let callImage = Image(systemName: activity.direction == .inbound ?
                                    "phone.arrow.up.right" :
                                    "phone.arrow.down.left")
                .font(.title)
            switch activity.callType {
            case .missed:
                callImage.foregroundColor(Color.red)
            case .voicemail:
                callImage.foregroundColor(Color.orange)
            case .answered:
                callImage.foregroundColor(Color.green)
            
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(activity.to ?? "Unknown number")
                    .font(.headline)
                Text("From \(activity.from)")
                    .font(.subheadline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text(activity.createdAt.string(withFormat: .dayAndMonth))
                    .font(.footnote)
                Text(activity.createdAt.string(withFormat: .hourAndMinutes))
                    .font(.footnote)
            }
            
            Button(action: {
                print("todo")
            }, label: {
                Image(systemName: "exclamationmark.circle")
                    .font(.title2)
                    .foregroundColor(Color.primary)
            })
        }
    }
    
}
