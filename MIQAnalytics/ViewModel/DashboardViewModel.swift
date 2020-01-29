    //
    //  DashboardViewModel.swift
    //  MIQAnalytics
    //
    //  Created by Girish on 16/01/20.
    //  Copyright © 2020 Girish. All rights reserved.
    //

    import UIKit

    protocol DashbardNotificationProtocal {
        func updateContentOnView()
       // func updateError()
        
        
    }

    class DashboardViewModel: NSObject {
        
        var delegate : DashbardNotificationProtocal?
        var kpiarray = [KPI]()
        var health : Health?
        var categoryhealth : CategoryHealth?
        var arrcategoryhealth = [CategoryHealth]()
        var peoplearray = [KPI]()
        var costarray = [KPI]()
        var  deliveryarray = [KPI]()
        var  qualityarray = [KPI]()
        var safteyarray = [KPI]()
        var arrcatagory = [String]()
        var kpivalues = [KPIValues]()
        

            func getCategoryListarray(array : [KPI]) -> [KPI]
            {
                for peopleDict in array
                {
                  let category = peopleDict.category as! String
                        if category == "People"
                        {
                            peoplearray.append(peopleDict)
                        }
                        if category == "Delivery"
                        {
                            deliveryarray.append(peopleDict)
                        }
                        if category == "Quality"
                        {
                            qualityarray.append(peopleDict)
                        }
                        if category == "Cost"
                        {
                            costarray.append(peopleDict)
                        }
                        if category == "Safety"
                        {
                            safteyarray.append(peopleDict)
                        }
                    
                
                    
                
                }
                print("the people aaary is ", (peoplearray))
                return array
            }
            func getHealthPercentageforPlant(array : [KPI])   {
                var ontargetcount : Int = 0
                var offtargetcount : Int = 0
                var vulenrabletargetcount: Int = 0
                var kpiTotalCount : Int = 0
                for peopleDict in array
                {
                    kpiTotalCount = kpiTotalCount + 1
                    
                  let status = peopleDict.status
                    if status == 1
                    {
                        ontargetcount = ontargetcount + 1
                    }
                    if status == 0
                    {
                        offtargetcount = offtargetcount + 1
                    }
                    if status == -1
                    {
                        vulenrabletargetcount = vulenrabletargetcount + 1
                    }
                
              }
                health = Health.init(with: ontargetcount, vulenrable: offtargetcount, offTarget: vulenrabletargetcount , kpiTotalCount:  kpiTotalCount)
                
            }
            
            func getvaluesontouchButtons(array : [KPI] , category : String , status : Int?) ->  [KPIValues]? {
                      var ontargetcount : Int = 0
                      var offtargetcount : Int = 0
                      var vulenrabletargetcount: Int = 0
                      var kpiTotalCount : Int = 0
                      var categoryname : String?
                      for peopleDict in array
                      {   categoryname = category
                       
                       if peopleDict.category == categoryname && peopleDict.status == status
                       {
                        kpivalues.append(KPIValues(with: peopleDict.actual, target: peopleDict.target, kpiName: peopleDict.category)!)
                    }
                   }
                      
                   return kpivalues
                   
                  }
            
            func getHealthPercentageforCategory2(array : [KPI] , category : String) ->  CategoryHealth? {
                   var ontargetcount : Int = 0
                   var offtargetcount : Int = 0
                   var vulenrabletargetcount: Int = 0
                   var kpiTotalCount : Int = 0
                   var categoryname : String?
                    var categoryID : Int?
                   for peopleDict in array
                   {   categoryname = category
                    
                    if peopleDict.category ==  categoryname || peopleDict.category!.caseInsensitiveCompare(category) == .orderedSame
                    {
                       categoryID = peopleDict.categoryID
                       kpiTotalCount = kpiTotalCount + 1
                       
                     let status = peopleDict.status
                       if status == 1
                       {
                           ontargetcount = ontargetcount + 1
                       }
                       if status == 0
                       {
                           offtargetcount = offtargetcount + 1
                       }
                       if status == -1
                       {
                           vulenrabletargetcount = vulenrabletargetcount + 1
                       }
                   
                 }
                }
                   categoryhealth = CategoryHealth.init(with: ontargetcount, vulenrable: offtargetcount, offTarget: vulenrabletargetcount , kpiTotalCount:  kpiTotalCount , categoryName: categoryname , categoryid: categoryID)
                return categoryhealth
                
               }
            
            func getHealthPercentageforCategory(array : [KPI] )   {
                var ontargetcount : Int = 0
                var offtargetcount : Int = 0
                var vulenrabletargetcount: Int = 0
                var kpiTotalCount : Int = 0
                var categoryname : String?
                var categoryID : Int?
                for peopleDict in array
                {   categoryname = peopleDict.category
                    kpiTotalCount = kpiTotalCount + 1
                    categoryID = peopleDict.categoryID
                  let status = peopleDict.status
                    if status == 1
                    {
                        ontargetcount = ontargetcount + 1
                    }
                    if status == 0
                    {
                        offtargetcount = offtargetcount + 1
                    }
                    if status == -1
                    {
                        vulenrabletargetcount = vulenrabletargetcount + 1
                    }
                
              }
                categoryhealth = CategoryHealth.init(with: ontargetcount, vulenrable: offtargetcount, offTarget: vulenrabletargetcount , kpiTotalCount:  kpiTotalCount , categoryName: categoryname, categoryid: categoryID)
                
            }
            
            
            
            func getCategoryList(array : [KPI]) -> [String]
               {
                   for peopleDict in array
                   {
                     let category = peopleDict.category as! String
                    
                    if !(arrcatagory.contains(category))  && !(arrcatagory.contains(category.uppercased()))
                    {
                    arrcatagory.append(category)
                    }
                           
                  
               }
                print("category list is \(arrcatagory)")
                 return arrcatagory
        }
            
            func dynamicarrayname(name : String) -> [String]?
            {
                var name : [String]?
                return name
            }
            
            func convertnumbertopercentage(first : Double , second : Double , third : Double) -> [Double]{
                var arr = [Double]()
                var total = first + second + third
                var a = ((first / total ) * 100)
                arr.append(Double(a))
                var b = (second / total ) * 100
                arr.append(Double(b))
                var c = (third / total ) * 100
                arr.append(Double(c))
               return arr
            }
            
        func fetchData(plantid : String) {
            DashboardNetworkManager.dashboardnetworkmanager.retrieveAPIData(plantid: plantid, userCompletionHandler: { [weak self] data , error in
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
                        print("json array is dashboard \(String(describing: array))")
                        
                        for peopleDict in array!
                        {
                                            if let dict = peopleDict as? [String: Any]{
                                                let plantid = (dict["PLANTID"] as! NSString).intValue
                                                
                                                let categoryID =   (dict["CATEGORYID"] as! NSString).intValue
                                                let category = dict["CATEGORY"] as! String
                                                let kpiID = (dict["KPIID"] as! NSString).intValue
                                                let kpi = dict["KPI"] as! NSString
                                                let createdDate = dict["CREATED_DATE"] as! NSString
                                                let actual = (dict["ACTUAL"] as! NSString).intValue
                                                let target = (dict["TARGET"] as! NSString).intValue
                                                let status = (dict["STATUS"] as! NSString).intValue
                                                let unit = dict["UNIT"] as! String
                                                let actualdate = dict["ACTUAL_DATE"] as! String
                                                let authKPI = (dict["AUTHKPI"] as? String ?? "0" )
                                                 let kpiType = dict["KPITYPE"] as! String
                                                
                        //                          let hirarchy = (dict["HIRARCHY"] as? NSString ?? "0").intValue
                                         
                                                
                                                self?.kpiarray.append(KPI(plantID: Int(plantid), categoryID: Int(categoryID), category: category, kpiID: Int(category), kpi: kpi as String, createdDate: createdDate as String, actual: Int(actual), target: Int(target), status: Int(status), unit: unit, actualdate: actualdate, authKPI: authKPI, kpiType: kpiType))
                                                
                                               
                                                
                        //                        self.placearray.append(Place(code: Int(code), comments: Comments, displayName: displayname, healthperc: Int(healthPrec), hirarchy: Int(hirarchy), latitude: latitude, longitude: longitude, map: Int(map), plantID: plantid))
                                                
                                            }
                                            
                                            
                                            
                                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    self?.getCategoryListarray(array: self?.kpiarray ?? [])
                    self?.getHealthPercentageforPlant( array: self?.kpiarray ?? [])
                    self?.getHealthPercentageforCategory(array: (self?.costarray ?? nil)!)
                    self?.getCategoryList(array:self!.kpiarray )
                    for arr in self?.arrcatagory ?? [""] {
                        let a = self?.getHealthPercentageforCategory2(array: self?.kpiarray as! [KPI], category: arr)
                    self?.arrcategoryhealth.append(a!)
                    // print("arr category health is \( self?.arrcategoryhealth)")
                    }
                    var aa = self!.arrcategoryhealth[0]

                    print("arr category health is \(String(describing: self?.arrcategoryhealth))")
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
                    
                })
            }
        }


