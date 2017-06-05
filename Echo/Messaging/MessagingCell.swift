//
//  MessagingCell.swift
//  Echo
//
//  Created by ShengHua Wu on 02/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class MessagingCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var message: Message? {
        didSet {
            message.flatMap {
                label.text = $0.text
                bubbleImageView.image = $0.isSentByMe ? UIImage(named: "right_bubble") : UIImage(named: "left_bubble")
            }
        }
    }
    
    // MARK: Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bubbleImageView.image = nil
    }
}
