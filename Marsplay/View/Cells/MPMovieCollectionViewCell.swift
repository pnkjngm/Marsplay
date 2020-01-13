//
//  MPMovieCollectionViewCell.swift
//  Marsplay
//
//  Created by Pankaj Kumar Nigam on 10/01/20.
//  Copyright © 2020 Pankaj Kumar Nigam. All rights reserved.
//

import UIKit

class MPMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgViewPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
    }
    
    func updateCell() {
        let screenWidth = UIScreen.main.bounds.width
        let posterWidth = screenWidth / 2 - 20
        let posterHeight = posterWidth * 1.3
        
        self.imgWidth.constant = posterWidth
        self.imgHeight.constant = posterHeight
    }
    func viewModelData(viewModel : MovieViewModel) {
        
        self.lblTitle.text = viewModel.title
        self.lblType.text = "Type: \(viewModel.type)"
        if let yearAgo = Int(viewModel.year) {
            self.lblYear.text = "\(2020 - yearAgo) years ago"
        } else {
            self.lblYear.text = viewModel.year
        }
        do {
            let imageData = try  Data(contentsOf : URL(string : viewModel.poster)!)
            self.imgViewPoster.image = UIImage(data : imageData)
        } catch {
            print("An Exception handled when data is not casted to Image:\(viewModel.poster)")
        }
        
    }
    
}
