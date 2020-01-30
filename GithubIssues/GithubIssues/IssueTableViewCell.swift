//
//  IssueTableViewCell.swift
//  GithubIssues
//
//  Created by Kiwiinthesky72 on 1/25/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet var issueTitle: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
