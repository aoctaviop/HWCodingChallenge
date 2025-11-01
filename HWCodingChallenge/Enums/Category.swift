//
//  Category.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

enum Category: String, CaseIterable {
    
    case business = "Business"
    case entertaiment = "Entertaiment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    case all = "All"
    
}

extension Category {
    
    var image: String {
        switch self {
        case .business:
            return "bag"
        case .entertaiment:
            return "tv"
        case .general:
            return "book"
        case .health:
            return "bandage"
        case .science:
            return "magnifyingglass"
        case .sports:
            return "figure.indoor.soccer"
        case .technology:
            return "network"
        case .all:
            return "slider.horizontal.3"
        }
    }
    
}
