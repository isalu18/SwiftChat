//
//  WelcomeViewController.swift
//  BestChatLAN
//
//  Created by Isaac Sanchez on 15/03/22.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.charInterval = 0.1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleLabel.text = "🚀 BestChatLAN 🚀"
    }

}

