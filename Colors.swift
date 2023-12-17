//
//  Colors.swift
//  Bike-App
//
//  Created by Munteanu, Cristian on 12.11.2023.
//

import Foundation
import SwiftUI

enum Colors: String, Equatable, CaseIterable {
    case red = "Red"
    case blue = "Blue"
    case green = "Green"
    case yellow = "Yellow"
    case orange = "Orange"
    case purple = "Purple"
    case black = "Black"
    case white = "White"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
