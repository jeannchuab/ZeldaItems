//
//  ItemTableViewCell.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 23/09/22.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageItem.layer.cornerRadius = 8
    }
    
    func setup(viewModel: ViewModel?, categoryItem: CategoryItemFormated) {
        activityIndicator.startAnimating()
        itemDescription.text = categoryItem.name        
        viewModel?.downloadImage(with: categoryItem.image) { image in
            self.activityIndicator.stopAnimating()
            self.imageItem.image = image
        }
    }
    
    override func prepareForReuse() {        
        itemDescription.text = ""
        imageItem.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
