//
//  Created by Edward Nagy on 07/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class DrinksViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let viewModel = DrinksViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Actions
extension DrinksViewController {

    @IBAction func addButtonTapped(_ sender: Any) {
        let registerController = RegisterDrinkViewController.instantiate()
        registerController.onClose = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?.tableView.reloadData()
        }
        present(viewController: registerController)
    }
}

// MARK: Table View Data Source
extension DrinksViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeaderInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = viewModel.drinkAt(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeDrinkAt(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}
