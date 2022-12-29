//
//  ImageModel.swift
//  MorningGlory
//
//  Created by Shashwat Panda on 07/11/22.
//

import Foundation

struct Results: Codable{
    var total: Int
    var results: [Result]
}
struct Result: Codable{
    var id: String
    var description: String
    var urls: [URLs]
}
struct URLs: Codable{
    var small: String
}
