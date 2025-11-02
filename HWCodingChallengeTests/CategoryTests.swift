//
//  CategoryTests.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 2/11/25.
//

import Foundation
import Testing
import XCTest

@testable import HWCodingChallenge

struct CategoryTests {

    @Test(
        arguments: Category.allCases
    )
    func Category_CategoryRawValueIsTheExpected(
        category: HWCodingChallenge.Category
    )
        async throws
    {
        var expectedRawValue = ""

        switch category {
        case .general:
            expectedRawValue = "General"
        case .business:
            expectedRawValue = "Business"
        case .entertaiment:
            expectedRawValue = "Entertaiment"
        case .health:
            expectedRawValue = "Health"
        case .science:
            expectedRawValue = "Science"
        case .sports:
            expectedRawValue = "Sports"
        case .technology:
            expectedRawValue = "Technology"
        }

        #expect(category.rawValue == expectedRawValue)
    }

    @Test(
        arguments: Category.allCases
    )
    func Category_CategoryImageIsTheExpected(
        category: HWCodingChallenge.Category
    )
        async throws
    {
        var expectedImage = ""

        switch category {
        case .general:
            expectedImage = "globe.desk"
        case .business:
            expectedImage = "suitcase"
        case .entertaiment:
            expectedImage = "theatermasks"
        case .health:
            expectedImage = "stethoscope"
        case .science:
            expectedImage = "flask"
        case .sports:
            expectedImage = "american.football"
        case .technology:
            expectedImage = "network"
        }

        #expect(category.image == expectedImage)
    }

}
