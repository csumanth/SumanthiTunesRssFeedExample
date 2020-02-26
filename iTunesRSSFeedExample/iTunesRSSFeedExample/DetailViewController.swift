//
//  DetailViewController.swift
//  iTunesRSSFeedExample
//
//  Created by Chidananda, Sumanth on 17/02/2020.
//  Copyright © 2020 Sumanth. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var albumnImageView: UIImageView!
    @IBOutlet weak var albumnName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var copyRight: UILabel!
    @IBOutlet weak var appleMusicButton: UIButton!
    
    var selectedCellViewModel: CellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumnImageView.layer.cornerRadius = (self.albumnImageView.frame.size.width/2)
        loadDisplayContent()
    }
    
    
    @IBAction func listenAppleMusicButtonTapped(_ sender: Any) {
        if let appleMusicUrl = selectedCellViewModel?.appleMusicUrl, appleMusicUrl.hasPrefix("https://") {
            let appleMusicUrlToLaunch = appleMusicUrl.dropFirst("https://".count)
            let url = URL(string: "music://\(appleMusicUrlToLaunch)")
            UIApplication.shared.open(url!) { (result) in
                if result {
                   // The URL was delivered successfully!
                    print("Successfully Opened")
                }
            }
        }
    }
}

private extension DetailViewController {
    func loadDisplayContent() {
        self.albumnImageView.image = selectedCellViewModel?.albumnImage
        self.albumnName.text = selectedCellViewModel?.albumnName
        self.artistName.text = selectedCellViewModel?.subTitle
        self.releaseDate.text = selectedCellViewModel?.releaseDate
        self.copyRight.text = selectedCellViewModel?.copyRight
    }
}
