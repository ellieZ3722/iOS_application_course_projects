//
//  IssueViewController.swift
//  GithubIssues
//
//  Created by Kiwiinthesky72 on 1/29/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import UIKit

class IssueViewController: UITableViewController {

    var issues = [GitHubIssue]()
    var segueIdentifier = ""
    var state = ""
    var imageName = ""
    var titleName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = titleName
        
        let client = GitHubClient()
        
        client.fetchIssues(state: state, completion: {(data, error) -> Void in
            if let data = data, error == nil {
                for dataEle in data {
                    self.issues.append(dataEle)
                }
                self.tableView.reloadData()
                
            } else {
                if let error = error {
                    print(error)
                }
            }
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> IssueTableViewCell {
        let cell: IssueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Issue", for: indexPath) as! IssueTableViewCell

        cell.issueTitle.text = issues[indexPath.row].title
        cell.username.text = "@\(issues[indexPath.row].user.login)"
        cell.img.image = UIImage(named: imageName)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == segueIdentifier,
            let vc = segue.destination as? IssueDetailViewController,
            let issueIndex = tableView.indexPathForSelectedRow?.row
        {
            vc.issuetitle = issues[issueIndex].title
    
            vc.body = issues[issueIndex].body
             
            let strToDateFormater = DateFormatter()
            strToDateFormater.locale = Locale(identifier: "en_US_POSIX")
            strToDateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            strToDateFormater.timeZone = TimeZone(secondsFromGMT: 0)
            let date = strToDateFormater.date(from: issues[issueIndex].createdAt)
            
            let dateToStr = DateFormatter()
            dateToStr.dateStyle = .long
            dateToStr.timeStyle = .none
            dateToStr.locale = Locale(identifier: "en_US")
            
            if let date = date {
                vc.Date = dateToStr.string(from: date)
            }
            
            vc.Username = "@\(issues[issueIndex].user.login)"
            vc.imageview = imageName
        }
    }

}
