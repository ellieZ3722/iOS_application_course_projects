//
//  ClosedIssueViewController.swift
//  GithubIssues
//
//  Created by Kiwiinthesky72 on 1/25/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit

class ClosedIssueViewController: IssueViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.segueIdentifier = "show2"
        self.state = "closed"
        self.imageName = "close_envelop"
        self.titleName = "Closed Issues"
    }
    
}
