//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Valentinas Mirosnicenko on 12/22/16.
//  Copyright © 2016 Valentinas Mirosnicenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()

    }
}
