//
//  BooksTableViewCell.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 30/09/23.
//

import UIKit

class BooksTableViewCell: UITableViewCell, URLSessionDelegate {
    
    var pdfUrl: URL?
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var genre: UILabel!
    
    @IBOutlet var bookTitle: UILabel!
    
    @IBOutlet var author: UILabel!
    var books: volume?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
   
    
    //extension BooksTableViewCell: URLSessionDownloadDelegate{
    //    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    //        print("downloadLocation:", location)
    //
    //        guard let url = downloadTask.originalRequest?.url else{return}
    //        let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    //        let destinationPath = docsPath.appending(path: url.lastPathComponent)
    //
    //        try? FileManager.default.removeItem(at: destinationPath)
    //
    //        do{
    //            try FileManager.default.copyItem(at: location, to: destinationPath)
    //            self.pdfUrl = destinationPath
    //            print("File Download Loaction: ", self.pdfUrl ?? "Not")
    //        }catch let error{
    //            print(error.localizedDescription)
    //        }
    //    }
    //}
}
