//
//  FeedTypeListViewController.swift
//  iTunesRSSFeedExample
//
//  Created by Chidananda, Sumanth on 19/02/2020.
//  Copyright © 2020 Sumanth. All rights reserved.
//

import UIKit

protocol FeedTypeListViewControllerDelegate: class {
    func didSelectedFeedType(selectedFeedType: String)
    func didDismissFeedTypeListPopover()
}

class FeedTypeListViewController: UIViewController {
    
    static let kTopAlbums = "Top Albums", kTopSongs = "Top Songs", kHotTracks = "Must Haves"
    static let kNewReleases = "New Music", kComingSoon = "Coming Soon"
    
    weak var delegate: FeedTypeListViewControllerDelegate?
    let dataSource = [FeedTypeListViewController.kTopAlbums,FeedTypeListViewController.kTopSongs,FeedTypeListViewController.kHotTracks,FeedTypeListViewController.kNewReleases,FeedTypeListViewController.kComingSoon]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 300, height: 220)
    }
}

extension FeedTypeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedListViewCell")
        let cellTitle = dataSource[indexPath.row]
        cell?.textLabel?.text = cellTitle
        return cell ?? UITableViewCell()
    }
}

extension FeedTypeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectedFeedType(selectedFeedType: dataSource[indexPath.row])
    }
}
