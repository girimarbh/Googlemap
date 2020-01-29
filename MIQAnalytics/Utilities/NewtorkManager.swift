//
//  NewtorkManager.swift
//  MIQAnalytics
//
//  Created by Girish on 04/12/19.
//  Copyright © 2019 Girish. All rights reserved.
//

import UIKit

struct Constants {
    
    struct APIDetails {
        static let APIScheme = "https"
        static let APIHost = "azurewebapiwiprodevelopment.azurewebsites.net"
        static let APIPath = "/api/central/CenGetHealthIndex"
    }
}

class NewtorkManager: NSObject {
    
    var url : NSURL?
    var placearray = [Place]()
    
    private func createURLFromParameters(parameters: [String:Any], pathparam: String?) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.APIDetails.APIScheme
        components.host   = Constants.APIDetails.APIHost
        components.path   = Constants.APIDetails.APIPath
        if let paramPath = pathparam {
            components.path = Constants.APIDetails.APIPath + "\(paramPath)"
        }
        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        
        return components.url!
    }
    
    static public let networkmanager = NewtorkManager()
    
    public override init() {
        

    }
    
    func retrieveAPIData(userCompletionHandler : @escaping (NSData? , NSError?) -> Void) {
        url = createURLFromParameters(parameters: ["EmailID" : "mpddashboard@hotmail.com"], pathparam: "") as NSURL
            var request: URLRequest = URLRequest(url: url! as URL)
            request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            // Request the data
            let session: URLSession = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                // print(data!.count)
                // Did we get an error?
                guard error == nil else {
                    print(error!)
                    
                    DispatchQueue.main.async{
                        //userCompletionHandler(nil , error as NSError?)
                    }
                    
                    return
                }
                
                guard let json = data else {
                    print("No data")
                    return
                }
                userCompletionHandler(json as NSData , error as NSError?)
                  
                }
                
            
            task.resume()
        }
    
   private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
