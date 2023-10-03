//
//  BookModel.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import Foundation

struct BookModel: Codable{
    
    var items: [volume]!
}
struct volume: Codable{
    var volumeInfo: volumeInformation
    var saleInfo: buyLink
    var accessInfo: pdf?
}
struct volumeInformation: Codable{
    
    var title: String?
    var authors:[String]?
    var publishedDate: String?
    var description: String?
    var averageRating: Float?
    var pageCount: Int?
    var categories:[String]?
    var imageLinks:image?
    var previewLink: String?
    var infoLink: String?
}
struct image:Codable{
    
    var smallThumbnail: String
    var thumbnail: String
}
struct buyLink: Codable{
//    var buyLink: String
}

struct pdf: Codable{
    var pdf:pdfDownload
    var webReaderLink: String?
}
struct pdfDownload:Codable{
    var isAvailable: Bool?
    var downloadLink: String?
    var acsTokenLink: String?
}
