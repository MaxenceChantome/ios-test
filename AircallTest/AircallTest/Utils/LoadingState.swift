//
//  State.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 07/07/2021.
//

import Foundation

/// Used when fetching data is needed
/// Allows the view to update its state if needed
enum LoadingState<T> {
    case idle
    case loading
    case failed(Error)
    case loaded(T)
    case empty
}
