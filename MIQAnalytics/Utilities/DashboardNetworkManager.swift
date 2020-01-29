//
//  DashboardNetworkManager.swift
//  MIQAnalytics
//
//  Created by Girish on 16/01/20.
//  Copyright © 2020 Girish. All rights reserved.
//

import UIKit

struct Constants2 {
    
    struct APIDetails {
        static let APIScheme = "https"
        static let APIHost = "azurewebapiwiprodevelopment.azurewebsites.net"
        static let APIPath = "/api/mpd"
    }
}

class DashboardNetworkManager: NSObject {
    
    var url : NSURL?
    var placearray = [Place]()
    
   private func createURLFromParameters2(parameters: [[String:Any]], pathparam: String?) -> URL {
            
            var components = URLComponents()
            components.scheme = Constants2.APIDetails.APIScheme
            components.host   = Constants2.APIDetails.APIHost
            
    //        switch item {
    //                 case .map:
    //                    print("first")
    //             components.path   = "abcccc"
    //                 case .dasboard:
    //                    print("second")
    //                     case .none:
    //                     print("third")
    //
    //
    //
    //                 case .none:
    //                     print("third")
    //             }
            
            components.path   = Constants2.APIDetails.APIPath
            if let paramPath = pathparam {
                components.path = Constants2.APIDetails.APIPath + "\(paramPath)"
            }
            if !parameters.isEmpty {
                components.queryItems = [URLQueryItem]()
                for a in parameters{
                for (key, value) in a {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    components.queryItems!.append(queryItem)
                }
                }
            }
            
            return components.url!
        }
    
    static public let dashboardnetworkmanager = DashboardNetworkManager()
    
    public override init() {
        

    }
    
    func retrieveAPIData(plantid : String , userCompletionHandler : @escaping (NSData? , NSError?) -> Void) {
      var  mail = "mpddashboard@hotmail.com"
      var  plantname = "Springfield"
        print("the plant id in fetch data is \(plantid)")
       // var  plantname = "Fairburn"
       url = self.createURLFromParameters2(parameters: [["PLANTID" : plantid],["EmailID" : mail]], pathparam: "") as NSURL
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

