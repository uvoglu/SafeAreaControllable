//
//  CoordinateSpace+Extensions.swift
//  
//
//  Created by Simon Schuhmacher on 07.03.22.
//

import SwiftUI

internal let coordinateSpaceName = "SACFrame"

internal extension CoordinateSpace {
    static let sacFrame = CoordinateSpace.named(coordinateSpaceName)
}
