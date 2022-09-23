//
//  DetailItemViewController.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 23/09/22.
//

import UIKit

class DetailItemViewController: UIViewController {
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelLocations: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let categoryItem = viewModel?.getSelectedCategoryItemFormated() else { return }
        
        viewModel?.downloadImage(with: categoryItem.image) { image in
            self.imageItem.image = image
        }
        
        labelName.text = categoryItem.name
        labelCategory.text = categoryItem.category
        labelLocations.text = categoryItem.commonLocations
        labelDescription.text = categoryItem.description
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
