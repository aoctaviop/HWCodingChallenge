//
//  News.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

struct News: Codable, Equatable {

    let articles: [Article]
    let totalResults: Int

}
