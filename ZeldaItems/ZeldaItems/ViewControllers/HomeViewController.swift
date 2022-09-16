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
    var category: Category = .creatures
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CategoryItemViewController {
            viewController.title = category.getTitle()
            viewController.viewModel = self.viewModel
        }
    }
}

extension HomeViewController: ViewModelDelegate {
    func showCategoryItems(_ category: Category) {
        self.category = category        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showCategoryItems", sender: self)
        }
    }
    
    func showError() {        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ops...", message: "Was not possible to load the items, please try again in a few seconds.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
