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
        tableView.register(UINib(nibName: String(describing: ItemTableViewCell.self) , bundle: nil),
                           forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailItemViewController {
            viewController.viewModel = self.viewModel
        }
    }
}

extension CategoryItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.categoryItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                        
        guard
            let categoryItem = self.viewModel?.categoryItems[indexPath.row],
            let item = viewModel?.getCategoryItemFormated(categoryItem),
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self),
                                                       for: indexPath) as? ItemTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.setup(viewModel: viewModel, categoryItem: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = viewModel?.categoryItems[indexPath.row]
        else { return }
        
        viewModel?.selectItem(item: selectedItem)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showDetailItem", sender: self)
        }
    }
}
