//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Valentinas Mirosnicenko on 12/23/16.
//  Copyright © 2016 Valentinas Mirosnicenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
