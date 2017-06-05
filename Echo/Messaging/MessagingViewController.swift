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
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
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
            self.textFieldBottomConstraint.constant += payload.endFrame.height
            
            UIView.animate(withDuration: payload.duration) {
                self.view.layoutIfNeeded()
            }
        }
        
        center.addObserver(with: UIViewController.keyboardWillHide) { (payload) in
            self.textFieldBottomConstraint.constant = 8
            
            UIView.animate(withDuration: payload.duration) {
                self.view.layoutIfNeeded()
            }
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
