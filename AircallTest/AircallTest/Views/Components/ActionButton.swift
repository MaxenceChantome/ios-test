//
//  ActionButton.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation
import SwiftUI

struct ActionButton: View {
    private let title: String
    private let image: String
    private let onSelect: (() -> Void)?
    
    init(title: String, image: String, select: (() -> Void)?) {
        self.title = title
        self.image = image
        self.onSelect = select
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Button(action: {
                onSelect?()
            }) {
                HStack {
                    Image(systemName: image)
                        .font(.headline)
                    Text(title)
                        .fontWeight(.semibold)
                        .font(.headline)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(Color.main)
                .cornerRadius(40)
            }
            Spacer()
        }
    }
}

