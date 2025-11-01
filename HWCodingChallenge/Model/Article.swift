//
//  Article.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

struct Article: Codable, Equatable {
    
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    
}
