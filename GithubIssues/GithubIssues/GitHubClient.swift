//
//  GitHubClient.swift
//  GithubIssues
//
//  Created by Kiwiinthesky72 on 1/26/20.
//  Copyright © 2020 Kiwiinthesky72. All rights reserved.
//

import Foundation

struct GitHubIssue: Codable{
    let title: String?
    let createdAt: String
    let body: String?
    let state: String
    let user: GitHubUser
    
    enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case body
        case state
        case user
    }
}

struct GitHubUser: Codable {
    let login: String
}

class GitHubClient {
    func fetchIssues(state: String, completion: @escaping ([GitHubIssue]?, Error?) -> Void) {
        let urlString = "https://api.github.com/repos/systemd/systemd/issues?state=\(state)"
        
        guard let url = URL(string: urlString) else {
            fatalError("Unable to create NSURL from string")
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            print("Response: \(String(describing: response))")
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {completion(nil, error)}
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let issues = try decoder.decode([GitHubIssue].self, from: data)
                DispatchQueue.main.async {completion(issues, nil)}
            } catch {
                DispatchQueue.main.async {completion(nil, error)}
            }
        })
        
        task.resume()
    }
}
