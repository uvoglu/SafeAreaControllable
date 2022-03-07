//
//  SafeAreaControllable.swift
//
//
//  Created by Simon Schuhmacher on 07.03.22.
//

import SwiftUI

public struct SafeAreaControllable<Content: View>: View {
    let content: Content

    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    @State private var innerFrame: CGRect = .zero
    @State private var outerFrame: CGRect = .zero

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ZStack {
            Spacer()
                .background(
                    GeometryReader { geometryProxy in
                        Spacer()
                            .preference(
                                key: SACInnerFramePreference.self,
                                value: geometryProxy.frame(in: .sacFrame)
                            )
                            .preference(
                                key: SACInsetsPreference.self,
                                value: geometryProxy.safeAreaInsets
                            )
                    }
                        .onPreferenceChange(SACInnerFramePreference.self) { value in
                            innerFrame = value
                        }
                        .onPreferenceChange(SACInsetsPreference.self) { value in
                            safeAreaInsets = value
                        }
                )
                .background(
                    GeometryReader { geometryProxy in
                        Spacer()
                            .preference(
                                key: SACOuterFramePreference.self,
                                value: geometryProxy.frame(in: .sacFrame)
                            )
                    }
                        .ignoresSafeArea()
                        .onPreferenceChange(SACOuterFramePreference.self) { value in
                            outerFrame = value
                        }
                )

            content
                .environment(\.sacInsets, safeAreaInsets)
                .environment(\.sacInnerFrame, innerFrame)
                .environment(\.sacOuterFrame, outerFrame)
                .ignoresSafeArea()
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}
