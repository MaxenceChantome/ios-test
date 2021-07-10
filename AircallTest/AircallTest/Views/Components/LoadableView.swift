//
//  AsyncView.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 09/07/2021.
//

import Foundation
import SwiftUI

struct LoadableView<ViewModel: LoadableViewModelType, Content: View>: View {
    @ObservedObject var viewModel: ViewModel
    private let content: (ViewModel.Output) -> Content
    
    init(viewModel: ViewModel, @ViewBuilder content: @escaping (ViewModel.Output) -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear {
                    viewModel.load()
                }
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, retry: nil)
            case .loaded(let output):
                content(output)
            }
        }
    }
    
}
