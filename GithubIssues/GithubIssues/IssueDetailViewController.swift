//
//  IssueDetailViewController.swift
//  GithubIssues
//
//  Created by Kiwiinthesky72 on 1/26/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {

    @IBOutlet var issueTitle: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var content: UITextView!
    
    var issuetitle: String?
    var body: String?
    var Date: String?
    var imageview: String?
    var Username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        issueTitle.text = issuetitle
        username.text = Username
        date.text = Date
        content.text = body
        
        if let imageview = imageview {
            imageView.image = UIImage(named: imageview)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
