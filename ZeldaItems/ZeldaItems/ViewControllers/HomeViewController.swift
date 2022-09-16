//
//  ViewController.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import UIKit

class HomeViewController: UIViewController {
        
    @IBOutlet weak var stackView: UIStackView!
    var viewModel: ViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(delegate: self)
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
            self.viewModel?.fetch(type: sender.titleLabel?.text ?? "")
        }
    }
}

extension HomeViewController: ViewModelDelegate {
    func showCategoryItems() {
        debugPrint(viewModel?.categoryItems)
    }
    
    func showError() {        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ops...", message: "Was not possible to load the items, please try again in a few seconds.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
