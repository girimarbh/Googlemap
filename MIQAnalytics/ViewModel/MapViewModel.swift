//
//  MapViewModel.swift
//  MIQAnalytics
//
//  Created by Girish on 04/12/19.
//  Copyright © 2019 Girish. All rights reserved.
//

import UIKit

protocol NotificationProtocal {
    func updateContentOnView()
   // func updateError()
    
    
}

class MapViewModel: NSObject {
    var delegate : NotificationProtocal?
    var placearray = [Place]()
    
    func fetchData() {
        NewtorkManager.networkmanager.retrieveAPIData(userCompletionHandler: { [weak self] data , error in
            guard let weakSelf = self else {
                return
            }
            guard error == nil else {
                print(error!)
                //self?.delegate?.updateError()
                return
            }
            guard let json = data else {
                print("No data")
                return
            }
            do {
                let array =  try JSONSerialization.jsonObject(with: json as Data, options: []) as? [Any]
                print("json array is \(String(describing: array))")
                
                for peopleDict in array!
                {
                    if let dict = peopleDict as? [String: Any]{
                        let code = dict["CODE"] as! String
                        let Comments = dict["COMMENTS"] as! String
                        let displayname = dict["DISPLAYNAME"] as! String
                        let healthPrec = (dict["HEALTHPERC"] as! NSString).intValue
                        let hirarchy = (dict["HIRARCHY"] as? NSString ?? "0").intValue
                        let latitude = (dict["LATITUDE"] as! NSString).doubleValue
                        let longitude = (dict["LONGITUDE"] as! NSString).doubleValue
                        let map = (dict["MAP"] as! NSString).intValue
                        let plantid = dict["PLANTID"] as! String
                        self?.placearray.append(Place(code: Int(code), comments: Comments, displayName: displayname, healthperc: Int(healthPrec), hirarchy: Int(hirarchy), latitude: latitude, longitude: longitude, map: Int(map), plantID: plantid))
                        }
                    
                    }
                
            } catch {
                print(error.localizedDescription)
            }
            weakSelf.delegate?.updateContentOnView()

            guard json.count != 0 else {
                print("Zero bytes of data")
                return
            }
            
            //  print("string is \(String(decoding: json, as: UTF8.self))")
            // let dict = self.convertToDictionary(text: String(decoding: json, as: UTF8.self))
            //                guard let tittle = list.productTittle else {
            //                    return
            //                }
            
            //                weakSelf.headerTittle = tittle
            //                weakSelf.datalist = list.productlist
            //weakSelf.delegate?.updateContentOnView()
        })
    }
}



