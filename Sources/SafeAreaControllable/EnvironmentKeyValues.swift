//
//  EnvironmentKeyValues.swift
//  
//
//  Created by Simon Schuhmacher on 07.03.22.
//

import SwiftUI

// MARK: - Environment Keys

internal struct SACInsetsEnvironment: EnvironmentKey {
    static let defaultValue: EdgeInsets = EdgeInsets()
}

internal struct SACOuterFrameEnvironment: EnvironmentKey {
    static let defaultValue: CGRect = .zero
}

internal struct SACInnerFrameEnvironment: EnvironmentKey {
    static let defaultValue: CGRect = .zero
}

// MARK: - Environment Values

internal extension EnvironmentValues {
    var sacInsets: EdgeInsets {
        get { self[SACInsetsEnvironment.self] }
        set { self[SACInsetsEnvironment.self] = newValue }
    }

    var sacOuterFrame: CGRect {
        get { self[SACOuterFrameEnvironment.self] }
        set { self[SACOuterFrameEnvironment.self] = newValue }
    }

    var sacInnerFrame: CGRect {
        get { self[SACInnerFrameEnvironment.self] }
        set { self[SACInnerFrameEnvironment.self] = newValue }
    }
}
