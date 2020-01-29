//
//  Dashboard.swift
//  MIQAnalytics
//
//  Created by Girish on 16/01/20.
//  Copyright © 2020 Girish. All rights reserved.
//

import UIKit

struct Health {
    var onTarget : Int?
    var vulenrable : Int?
    var offTarget : Int?
    var kpiTotalCount : Int?
    
    init?(with onTarget:Int?, vulenrable:Int?,offTarget : Int? , kpiTotalCount : Int? ) {
           self.onTarget = onTarget
           self.vulenrable = vulenrable
        self.kpiTotalCount = kpiTotalCount
        self.offTarget = offTarget
       }
}

struct CategoryHealth {
    var onTarget : Int?
    var vulenrable : Int?
    var offTarget : Int?
    var kpiTotalCount : Int?
    var categoryName : String?
    var categoryID : Int?
    
    init?(with onTarget:Int?, vulenrable:Int?,offTarget : Int? , kpiTotalCount : Int?  , categoryName : String? , categoryid : Int?)  {
        self.onTarget = onTarget
        self.vulenrable = vulenrable
        self.kpiTotalCount = kpiTotalCount
        self.offTarget = offTarget
        self.categoryName = categoryName
        self.categoryID = categoryid
       }
}

struct KPIValues {
    var actual : Int?
    var target : Int?
    var kpiName : String?
   
    
    init?(with actual:Int?, target:Int?,kpiName : String? ) {
        self.actual = actual
        self.actual = actual
        self.kpiName = kpiName

       }
}

struct KPI
{
    
    var plantID : Int?
    var categoryID : Int?
    var category : String?
    var kpiID : Int?
    var kpi : String?
    var createdDate : String?
    var actual : Int?
    var target : Int?
    var status : Int?
    var unit : String?
    var actualdate : String?
    var authKPI : String?
    var kpiType: String?
    
    
}

class Dashboard: NSObject {

}
