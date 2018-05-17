//
//  Constants.swift
//  DreamLister
//
//  Created by Valentinas Mirosnicenko on 5/17/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import Foundation

let TEST_DATA_CREATED = "TEST_DATA_CREATED"

func createTestData(){
    
    let store1 = Store(context: context)
    store1.name = "Walmart"
    let store2 = Store(context: context)
    store2.name = "SevenEleven"
    let store3 = Store(context: context)
    store3.name = "Market"
    let store4 = Store(context: context)
    store4.name = "eBay"
    let store5 = Store(context: context)
    store5.name = "Amazon"
    let store6 = Store(context: context)
    store6.name = "Taobao"
    
    let type1 = ItemType(context: context)
    type1.type = "Books"
    let type2 = ItemType(context: context)
    type2.type = "Cosmetics"
    let type3 = ItemType(context: context)
    type3.type = "Clothes"
    let type4 = ItemType(context: context)
    type4.type = "Electronics"
    let type5 = ItemType(context: context)
    type5.type = "Tools"
    let type6 = ItemType(context: context)
    type6.type = "Other"
    
    ad.saveContext()
}
