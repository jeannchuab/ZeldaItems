//
//  ViewController.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import UIKit

class HomeViewController: UIViewController {
        
    @IBOutlet weak var stackView: UIStackView!
    var viewModel = ViewModel()
    var category: Category = .creatures
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        for item in stackView.arrangedSubviews {
            if let button = item as? UIButton {
                button.layer.cornerRadius = 16
            }
        }
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        Animations.animateButton(sender) {
            self.viewModel.selectCategory(sender.titleLabel?.text ?? "")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showCategoryItems", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ListItemViewController {            
            viewController.viewModel = self.viewModel
            viewModel.delegateListItems = viewController
        }
    }
}
