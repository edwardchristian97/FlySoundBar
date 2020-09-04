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
        //setupNavigationBar()
        setupRevealingSplashView()
        fetchParties()
    }
}

// MARK: UI Setup
extension PartyViewController {

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

    private func fetchParties() {
        checkEmptyList()
    }

    private func checkEmptyList() {
        if viewModel.numberOfRows == 0 { tableView.setEmptyList(withMessage: "Nu exista party-uri")}
    }
}

// MARK: Actions
extension PartyViewController {

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let registerController = RegisterPartyViewController.instantiate()
        registerController.onClose = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        present(viewController: registerController)
    }
}

// MARK: UITableView Data Source
extension PartyViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { viewModel.numberOfSections }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.numberOfRows }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
