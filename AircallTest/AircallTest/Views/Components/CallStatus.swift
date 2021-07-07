//
//  CallStatus.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 06/07/2021.
//

import Foundation
import SwiftUI


struct CallStatus: View {
    var activity: Activity
    
    var body: some View {
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
    }
}

struct CallStatus_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(Activities.mockedData) { activity in
            CallStatus(activity: activity)
                .previewLayout(.sizeThatFits)
        }
    }
}
