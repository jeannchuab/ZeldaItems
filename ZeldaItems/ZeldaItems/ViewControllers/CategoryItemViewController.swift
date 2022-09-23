//
//  CategoryItemViewController.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import UIKit

class CategoryItemViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: ItemCell.self) , bundle: nil), forCellReuseIdentifier: String(describing: ItemCell.self))
    }
}

extension CategoryItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.categoryItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemCell.self),
                                                       for: indexPath) as? ItemCell
        else {
            return UITableViewCell()
        }

        cell.itemDescription.text = viewModel?.categoryItems[indexPath.row].name?.capitalized

        DispatchQueue.global().async {
            if let urlPhoto = URL(string: self.viewModel?.categoryItems[indexPath.row].image ?? "") {
                do {
                    let data = try Data(contentsOf: urlPhoto)
                    let image = UIImage(data: data)

                    DispatchQueue.main.async {
                        cell.imageItem.image = image
                    }
                } catch _ {}
            }
        }

        return cell
    }
}
