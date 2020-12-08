//
//  Created by Edward Nagy on 08/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class PartyDetailsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalLabel: UILabel!

    private var viewModel = PartyDetailsViewModel()
    var onTotalChanged: ((Int64) -> Void)?
    var party: Party?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let party = sender as? Party {
            if let controller = segue.destination as? DrinksInventoryViewController {
                controller.party = party
                controller.onOrderPaid = { [weak self] in
                    self?.onTotalChanged?(self?.viewModel.paidDrinksTotal ?? 0)
                    self?.setTotalLabel()
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: UI Setup
extension PartyDetailsViewController {

    private func setup() {
        navigationItem.title = party?.name
        viewModel.party = party
        setTotalLabel()
    }

    private func setTotalLabel() {
        totalLabel.text = "\(viewModel.titleForHeader)"
    }
}

// MARK: Table View Data Source
extension PartyDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "InventoryCell")
//        let paidDrinkName = viewModel.paidDrinkAt(index: indexPath.row).name
//        let paidDrinkQuantity = viewModel.paidDrinkAt(index: indexPath.row).quantity
//
//        cell.textLabel?.text = "\(paidDrinkName ?? "") x\(paidDrinkQuantity)"
        let paidDrink = viewModel.paidDrinkAt(index: indexPath.row)
        cell.textLabel?.text = "\(paidDrink.name) x\(paidDrink.quantity)"
        cell.detailTextLabel?.text = "\(viewModel.paidDrinkTotalAt(index: indexPath.row)) RON"
        return cell

    }
}

// MARK: Actions
extension PartyDetailsViewController {

    @IBAction private func newInventoryTapped(_ sender: RoundButton) {
        performSegue(withIdentifier: "DrinksInventorySegue", sender: party)
    }
}
