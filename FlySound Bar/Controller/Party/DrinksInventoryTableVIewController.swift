//
//  Created by Edward Nagy on 08/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit
import PKHUD

final class DrinksInventoryViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var cartView: UIView!
    @IBOutlet private weak var cartViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var payButton: RoundButton!
    
    private let viewModel = InventoryViewModel()
    var onOrderPaid: (() -> Void)?
    var party: Party?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: UI Setup
extension DrinksInventoryViewController {

    private func setup() {
        tableView.register(cell: DrinksCell.self)
        cartView.layer.cornerRadius = 10
        cartViewBottomConstraint.constant = -cartView.frame.height
    }
}

// MARK: Actions
extension DrinksInventoryViewController {

    @IBAction func resetButtonTapped(_ sender: Any) {
        reset()
    }

    @IBAction func payButtonTapped(_ sender: Any) {
        guard let party = party else { return }
        viewModel.addDrinksToParty(party)
        onOrderPaid?()
        HUD.flash(.label("Achitat: \(viewModel.total) RON"), delay: 0.7)
        reset()
    }
}

// MARK: Functions
extension DrinksInventoryViewController {

    private func reset() {
        viewModel.resetInventory()
        tableView.reloadData()
        updatePayButton()
    }

    private func updatePayButton() {
        UIView.performWithoutAnimation {
            payButton.setTitle("Achita Comanda (\(viewModel.total) RON)", for: .normal)
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.2) {
            self.cartViewBottomConstraint.constant = self.viewModel.total > 0 ? -8: -self.cartView.frame.height
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Table View Data Source
extension DrinksInventoryViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DrinksCell = tableView.dequeue(for: indexPath)

        cell.setup(drinkName: viewModel.drinkAt(indexPath: indexPath), quantity: viewModel.quantityAt(indexPath: indexPath))
        cell.setColorForQuantity(viewModel.quantityAt(indexPath: indexPath))
        cell.onMinusTapped = { [weak self] in
            self?.viewModel.decreaseQuantityAt(indexPath: indexPath)
            self?.tableView.reloadRows(at: [indexPath], with: .none)
            self?.updatePayButton()
        }
        cell.onPlusTapped = { [weak self] in
            self?.viewModel.increaseQuantityAt(indexPath: indexPath)
            self?.tableView.reloadRows(at: [indexPath], with: .none)
            self?.updatePayButton()
        }
        return cell
    }
}

extension DrinksInventoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = .black
        
        let sectionLabel = UILabel()
        sectionLabel.frame = CGRect(x: 20, y: 24, width: 300, height: 45)
        sectionLabel.text = viewModel.titleForHeaderInSection(section)
        sectionLabel.font = .boldSystemFont(ofSize: 24)

        sectionView.addSubview(sectionLabel)
        return sectionView
    }
}
