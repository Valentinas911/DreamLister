//
//  ItemCell.swift
//  DreamLister
//
//  Created by Valentinas Mirosnicenko on 12/23/16.
//  Copyright © 2016 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var type: UILabel!
    //description is often a reserved word. Use details!!!
    @IBOutlet weak var details: UILabel!
    
    func configureCell(item:Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        type.text = item.toItemType?.type
        thumb.image = item.toImage?.image as? UIImage
    }

}
