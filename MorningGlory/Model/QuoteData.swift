//
//  QuoteFile.swift
//  MorningGlory
//
//  Created by Shashwat Panda on 10/11/22.
//

import Foundation

struct QuoteData: Codable{
    let _id: String
    let content: String
    let author: String
    
    let authorSlug:String
    let length: Int
    let dateAdded: String
    let dateModified: String
    
}
