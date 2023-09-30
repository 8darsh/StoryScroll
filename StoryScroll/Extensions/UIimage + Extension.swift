//
//  UIimage + Extension.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 30/09/23.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else{
            return
        }
        
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
