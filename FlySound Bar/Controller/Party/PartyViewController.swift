//
//  Created by Edward Nagy on 28/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit
import RevealingSplashView
import CoreData

class PartyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let viewModel = PartyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRevealingSplashView()
        registerCells()
        checkEmptyList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.separatorStyle = .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let party = sender as? Party {
            if let controller = segue.destination as? PartyDetailsViewController {
                controller.party = party
                controller.onTotalChanged = { total in
                    self.viewModel.updateTotal(total, forParty: party)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: UI Setup
extension PartyViewController {

    private func registerCells() {
        tableView.register(cell: PartyCell.self)
    }

    //    private func setupNavigationBar() {
    //        let imageView = UIImageView(image: UIImage(named: "BarIcon"))
    //        imageView.frame = CGRect(x: 50, y: 50, width: 32, height: 32)
    //        imageView.contentMode = .scaleAspectFit
    //        navigationItem.titleView = imageView
    //    }

    private func setupRevealingSplashView() {
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "AppLogo")!,
                                                      iconInitialSize: CGSize(width: UIScreen.main.bounds.width,
                                                                              height: UIScreen.main.bounds.height),
                                                      backgroundColor: .black)
        view.addSubview(revealingSplashView)
        revealingSplashView.startAnimation()
    }
}

// MARK: Functions
extension PartyViewController {

    private func checkEmptyList() {
        if viewModel.numberOfRows == 0 {
            tableView.setEmptyList(withMessage: "Nu exista niciun party inregistrat.\nApasa pe + pentru a adauga un party.")
        } else {
            tableView.resetList()
        }
    }
}

// MARK: Actions
extension PartyViewController {

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let registerController = RegisterPartyViewController.instantiate()
        registerController.onClose = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?.checkEmptyList()
        }
        present(viewController: registerController)
    }
}

// MARK: UITableView Data Source
extension PartyViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PartyCell = tableView.dequeue(for: indexPath)
        cell.setup(party: viewModel.partyAt(index: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removePartyAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            checkEmptyList()
        }
    }
}

// MARK: UITable View Delegate
extension PartyViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PartyDetailsSegue", sender: viewModel.partyAt(index: indexPath.row))
    }
}
