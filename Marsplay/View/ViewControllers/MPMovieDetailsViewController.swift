//
//  MPMovieDetailsViewController.swift
//  Marsplay
//
//  Created by Pankaj Kumar Nigam on 12/01/20.
//  Copyright © 2020 Pankaj Kumar Nigam. All rights reserved.
//

import UIKit

class MPMovieDetailsViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var imgVeiwPoster: UIImageView!
    
    var movieTitle = String()
    var movieType = String()
    var movieYear = String()
    var strUrlImage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTitle.text = movieTitle
        self.lblType.text = "Type: \(movieType)"
        self.lblYear.text = "Year: \(movieYear)"
        do {
            let imageData = try  Data(contentsOf : URL(string : strUrlImage)!)
            self.imgVeiwPoster.image = UIImage(data : imageData)
        } catch {
            print("Some error on image")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.updatingScrollView()
    }
    override func viewWillLayoutSubviews() {
        self.updatingScrollView()
    }
    
    func updatingScrollView() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        if screenWidth > screenHeight {
            var contentinset = self.scrollView.contentInset
            contentinset.bottom = abs(screenHeight - screenWidth)
            self.scrollView.contentInset = contentinset
        } else {
            let contentinset = UIEdgeInsets.zero
            self.scrollView.contentInset = contentinset
        }
    }
}
