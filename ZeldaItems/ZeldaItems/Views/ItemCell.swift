//
//  ItemCell.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import UIKit

class ItemCell: UITableViewCell {        
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        itemDescription.textAlignment = .center
        itemDescription.text = ""
        imageItem.image = nil
    }
}
