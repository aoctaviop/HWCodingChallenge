//
//  Category.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

/// Represents different categories that can be used for the news feed.
enum Category: String, CaseIterable {

    case general = "General"
    case business = "Business"
    case entertaiment = "Entertaiment"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"

}

extension Category {

    var image: String {
        switch self {
        case .business:
            return "suitcase"
        case .entertaiment:
            return "theatermasks"
        case .health:
            return "stethoscope"
        case .science:
            return "flask"
        case .sports:
            return "american.football"
        case .technology:
            return "network"
        case .general:
            return "globe.desk"
        }
    }

}
