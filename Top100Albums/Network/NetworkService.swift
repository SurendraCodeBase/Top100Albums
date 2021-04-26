//
//  NetworkService.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/23/21.
//

import Foundation

class NetworkService {
  
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completionHandler: @escaping (ResponseResult<T>) -> Void) {

        guard let dataURL = URL(string: url) else{
            completionHandler(ResponseResult.failure(APPError.dataNotFound))
            return
        }

        let session = URLSession.shared
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            if let error = error {
                completionHandler(ResponseResult.failure(APPError.networkError(error)))
                return
            }

            guard let data = data else {
                completionHandler(ResponseResult.failure(APPError.dataNotFound))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completionHandler(ResponseResult.success(decodedObject))
            } catch let error {
                guard let error = error as? DecodingError else {
                    completionHandler(ResponseResult.failure(APPError.dataNotFound))
                    return
                }
                completionHandler(ResponseResult.failure(APPError.jsonParsingError(error)))
            }
        })

        task.resume()
    }
}
