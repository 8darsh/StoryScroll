//
//  BookModel.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 29/09/23.
//

import Foundation

struct BookModel: Codable{
    
    var items: [volume]
}
struct volume: Codable{
    var volumeInfo: volumeInfo
    var saleInfo: buyLink
    var accessInfo: pdf?
}
struct volumeInfo: Codable{
    
    var title: String?
    var authors:[String]?
    var publishedDate: String?
    var pageCount: Int?
    var categories:[String]?
    var imageLinks:image?
    var previewLink: String?

}
struct image:Codable{
    
    var smallThumbnail: String
}
struct buyLink: Codable{
    var buyLink: String
}

struct pdf: Codable{
    var pdf:pdfDownload
}
struct pdfDownload:Codable{
    var downloadLink: String?
}
