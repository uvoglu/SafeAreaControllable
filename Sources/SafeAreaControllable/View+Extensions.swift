//
//  View+Extensions.swift
//  
//
//  Created by Simon Schuhmacher on 07.03.22.
//

import SwiftUI

public extension View {
    func insetToSafeArea(_ edge: Edge, coordinateSpace: CoordinateSpace? = nil) -> some View {
        modifier(
            SACInsetModifier(edge: edge, coordinateSpace: coordinateSpace ?? .sacFrame)
        )
    }
}
