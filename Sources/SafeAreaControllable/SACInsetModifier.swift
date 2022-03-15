//
//  SACInsetModifier.swift
//  
//
//  Created by Simon Schuhmacher on 07.03.22.
//

import SwiftUI

internal struct SACInsetModifier: ViewModifier {
    @Environment(\.isPreview) var isPreview
    
    @Environment(\.sacInsets) private var safeAreaInsets
    @Environment(\.sacInnerFrame) private var safeAreaFrame
    @Environment(\.sacOuterFrame) private var fullFrame

    @State private var elementFrame: CGRect = .zero

    let edge: Edge
    let coordinateSpace: CoordinateSpace

    init(edge: Edge, coordinateSpace: CoordinateSpace) {
        self.edge = edge
        self.coordinateSpace = coordinateSpace
    }

    func body(content: Self.Content) -> some View {
        content
            .padding(Edge.Set(edge), calculatePadding(edge)) // needs to run before background `GeometryReader`
            .background(
                GeometryReader { geometryProxy in
                    Spacer()
                        .preference(
                            key: SACElementFramePreference.self,
                            value: geometryProxy.frame(in: coordinateSpace)
                        )
                }
                    .onPreferenceChange(SACElementFramePreference.self) { value in
                        DispatchQueue.main.async {
                            elementFrame = value
                        }
                    }
            )
    }

    private func calculatePadding(_ edge: Edge) -> CGFloat {
        guard !isPreview else { return 0.0 }
        
        let difference: CGFloat
        switch edge {
        case .leading:
            difference = safeAreaInsets.leading - elementFrame.minX
        case .trailing:
            let trailingOffset = fullFrame.maxX - elementFrame.maxX
            difference = safeAreaInsets.trailing - trailingOffset
        case .top:
            difference = safeAreaInsets.top - elementFrame.minY
        case .bottom:
            let bottomOffset = fullFrame.maxY - elementFrame.maxY
            difference = safeAreaInsets.bottom - bottomOffset
        }
        return max(0, difference)
    }

}
