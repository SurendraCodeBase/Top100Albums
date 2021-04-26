//
//  ImageStore.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import Foundation
import UIKit

class ImageStore {
    static let sharedImageStore  = ImageStore()
    private var imageStore = [String:UIImage]()
       
    func getImage(forUrl:URL, completionHandler: @escaping (UIImage) -> Void) {
        
       if let image = self.imageStore[forUrl.absoluteString]  {
            completionHandler(image)
        }else{
            URLSession.shared.dataTask(with: forUrl) { [self] data, response, error in
                let noImage = UIImage(named: Constants.kNoImageKey.rawValue) ?? UIImage()
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = httpURLResponse.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else {
                    completionHandler(noImage)
                    return
                }
                
                if let url = httpURLResponse.url  {
                        self.imageStore[url.absoluteString] = image
                        completionHandler(image)
                }else{
                    completionHandler(noImage)
                }
            }.resume()
        }
    }
}
