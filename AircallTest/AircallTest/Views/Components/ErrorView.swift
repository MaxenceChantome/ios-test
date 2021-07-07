//
//  ErrorView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    var onRetry: (() -> Void)?
    private let error: Error
    
    /// Init with error and function to trigger in order to retry api call
    init(error: Error, retry: (() -> Void)?) {
        self.error = error
        self.onRetry = retry
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
            Text(error.localizedDescription)
                .font(.body)
                .multilineTextAlignment(.center)
            
            Button(action: {
                onRetry?()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .font(.headline)
                    Text("Retry")
                        .fontWeight(.semibold)
                        .font(.headline)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(Color.main)
                .cornerRadius(40)
            }
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let error = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "An error occured"])
        ErrorView(error: error, retry: nil)
    }
}

