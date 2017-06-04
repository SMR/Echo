//
//  MessagingViewController.swift
//  Echo
//
//  Created by ShengHua Wu on 02/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Messaging View Controller
final class MessagingViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var viewModel: MessagingViewModel!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterNotifications()
    }
    
    // MARK: Public Methods
    func updateUI(with state: State<[Message]>) {
        switch state {
        case .normal:
            tableView.reloadData()
        }
    }
    
    // MARK: Register & unregister notifications
    private func registerNotifications() {
        let center = NotificationCenter.default
        
        center.addObserver(with: UIViewController.keyboardWillShow) { (payload) in
            let contentInset = UIEdgeInsetsMake(0.0, 0.0, payload.endFrame.height, 0.0)
            self.tableView.contentInset = contentInset
            self.tableView.scrollIndicatorInsets = contentInset
            
            // TODO: Move text field
        }
        
        center.addObserver(with: UIViewController.keyboardWillHide) { (payload) in
            let contentInset = UIEdgeInsets.zero
            self.tableView.contentInset = contentInset
            self.tableView.scrollIndicatorInsets = contentInset
            
            // TOOD: Move text field
        }
    }
    
    private func unregisterNotifications() {
        let center = NotificationCenter.default
        center.removeObserver(self, name: UIViewController.keyboardWillShow.name, object: nil)
        center.removeObserver(self, name: UIViewController.keyboardWillHide.name, object: nil)
    }
}

// MARK: - Table View Data Source
extension MessagingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagingCell", for: indexPath) as! MessagingCell
        
        cell.label?.text = viewModel.state.element(at: indexPath.row).text
        
        return cell
    }
}
