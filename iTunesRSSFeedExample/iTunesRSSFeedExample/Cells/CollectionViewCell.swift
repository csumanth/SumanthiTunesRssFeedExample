//
//  CollectionViewCell.swift
//  iTunesRSSFeedExample
//
//  Created by Chidananda, Sumanth on 17/02/2020.
//  Copyright © 2020 Sumanth. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var albumnImage: UIImageView!
    @IBOutlet var albumnName: UILabel!
    @IBOutlet var subTitle: UILabel!
    
    
    func displayContent(cellViewModel: CellViewModel) {
        self.albumnImage.image = cellViewModel.albumnImage
        self.albumnName.text = cellViewModel.albumnName
        self.subTitle.text = cellViewModel.subTitle
    }
}


//
// MARK: - CellViewModel
//
struct CellViewModel {
    let albumnName: String // name
    let subTitle: String // artistName
    var albumnImage: UIImage?
    let imageUrl: String
    let copyRight: String
    let releaseDate: String
    let appleMusicUrl: String
}
