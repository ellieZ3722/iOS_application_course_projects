//
//  OpenIssueViewController.swift
//  GithubIssues
//
//  Created by Kiwiinthesky72 on 1/25/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit

class OpenIssueViewController: IssueViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.segueIdentifier = "show1"
        self.state = "open"
        self.imageName = "open_envelop"
        self.titleName = "Opened Issues"
    }
    
}
