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
                                
        guard let categoryItem = viewModel?.selectedCategoryItem else { return }
        
        //TODO: Move to ImageDownloaderClass
        DispatchQueue.global().async {
            if let urlPhoto = URL(string: categoryItem.image ?? "") {
                do {
                    let data = try Data(contentsOf: urlPhoto)
                    let image = UIImage(data: data)

                    DispatchQueue.main.async {
                        self.imageItem.image = image
                    }
                } catch _ {}
            }
        }
        
        labelName.text = categoryItem.name
//        labelCategory.text = categoryItem?.category
        labelLocations.text = categoryItem.commonLocations?[0] //TODO
        labelDescription.text = categoryItem.description
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
