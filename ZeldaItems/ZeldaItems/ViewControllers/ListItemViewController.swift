//
//  CategoryItemViewController.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import UIKit

class ListItemViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: ViewModel?
    var listCategoriesItems: [CategoryItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.delegateListItems = self
        activityIndicator.startAnimating()
        viewModel?.fetch()
        
        self.title = viewModel?.category.getTitle()
        
        textFieldSearch.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: ItemTableViewCell.self) , bundle: nil),
                           forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailItemViewController {
            viewModel?.delegateListItems = self
            viewController.viewModel = self.viewModel
        }
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        viewModel?.search(text: textFieldSearch.text)
    }
}

extension ListItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listCategoriesItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                        
        guard
            let categoryItem = self.listCategoriesItems?[indexPath.row],
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
        guard let selectedItem = self.listCategoriesItems?[indexPath.row]
        else { return }
        
        viewModel?.selectListItem(item: selectedItem)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showDetailItem", sender: self)
        }
    }
}

extension ListItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel?.search(text: textField.text ?? "")
        textFieldSearch.endEditing(true)
        return true
    }
}

extension ListItemViewController: ViewModelListItemDelegate {
    func updateItems(_ category: Category, listCategoriesItems: [CategoryItem]) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.listCategoriesItems = listCategoriesItems
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ops...", message: "Was not possible to load the items, please try again in a few seconds.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
}
