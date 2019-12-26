//
//  HeroCell.swift
//  combineTest
//
//  Created by Gregory SeungHyun Jin on 2019/12/26.
//  Copyright © 2019 Gregory SeungHyun Jin. All rights reserved.
//

import UIKit
import Combine
class HeroCell: UITableViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var fullnameLabel:UILabel!
    @IBOutlet weak var publisherLabel:UILabel!
    
    var heros = PassthroughSubject<Heros,Never>()
    
    var cancellable = Set<AnyCancellable>()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.heros .sink { [weak self] (heros) in
            DispatchQueue.main.async {
                self?.nameLabel.text = heros.name
                self?.fullnameLabel.text = heros.biography?.fullName
                self?.publisherLabel.text = heros.biography?.publisher
                if let imgUr = heros.image?.url {
                    self?.thumbnailView.imageFromServerURL(imgUr, placeHolder: nil)
                }
                else {
                    self?.thumbnailView.image = nil
                }
                
            }
        }
        .store(in: &cancellable)
    }
}
