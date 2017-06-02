//
//  MessagingViewController.swift
//  Echo
//
//  Created by ShengHua Wu on 02/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Messaging View Controller
final class MessagingViewController: UITableViewController {
    // MARK: Properties
    var viewModel: MessagingViewModel!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Public Methods
    func updateUI(with state: State<[Message]>) {
        switch state {
        case .normal:
            tableView.reloadData()
        }
    }
}

// MARK: - Table View Data Source
extension MessagingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagingCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.state.element(at: indexPath.row).text
        
        return cell
    }
}
