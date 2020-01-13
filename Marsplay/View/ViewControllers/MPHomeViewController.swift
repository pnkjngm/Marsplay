//
//  MPHomeViewController.swift
//  Marsplay
//
//  Created by Pankaj Kumar Nigam on 10/01/20.
//  Copyright © 2020 Pankaj Kumar Nigam. All rights reserved.
//

import UIKit

class MPHomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: MovieViewModel!
    var moviesData = [[String : String]]()
    var page : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Register for CollectionView Cell XIBs
        self.collectionView.register(UINib(nibName: "MPMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MPMovieCollectionViewCell")
        self.collectionView.register(UINib(nibName: "MPLoadingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MPLoadingCollectionViewCell")
    }
    
    //If rotation takes place
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK:- Data Source
extension MPHomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesData.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == self.moviesData.count { // which means last element
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MPLoadingCollectionViewCell", for: indexPath) as! MPLoadingCollectionViewCell
            cell.activityIndicator.startAnimating()
            cell.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
            
            guard page < 10 else { return cell }
            self.page += 1
            self.loadNextPage()
            
            return cell
            
        }
        
      
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MPMovieCollectionViewCell", for: indexPath) as! MPMovieCollectionViewCell
        cell.tag = indexPath.row
        viewModel = MovieViewModel(title: self.moviesData[indexPath.row]["title"] ?? "DEFAULT",
                                   type: self.moviesData[indexPath.row]["type"] ?? "DEFAULT",
                                   imdbID: self.moviesData[indexPath.row]["imdbID"] ?? "DEFAULT",
                                   year: self.moviesData[indexPath.row]["year"] ?? "DEFAULT",
                                   poster: self.moviesData[indexPath.row]["poster"] ?? "DEFAULT")
        cell.viewModelData(viewModel: viewModel)
        cell.updateCell()
        
        return cell
    }
    
}

//MARK:- Delegate
extension MPHomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        guard indexPath.row < 100 else { return }
        let details = self.storyboard?.instantiateViewController(withIdentifier:"MPMovieDetailsViewController") as! MPMovieDetailsViewController
        details.movieTitle = self.moviesData[indexPath.row]["title"] ?? "DEFAULT"
        details.movieType = self.moviesData[indexPath.row]["type"] ?? "DEFAULT"
        details.movieYear = self.moviesData[indexPath.row]["year"] ?? "DEFAULT"
        details.strUrlImage = self.moviesData[indexPath.row]["poster"] ?? "DEFAULT"
        self.navigationController?.pushViewController(details, animated: true)
    }
}

//MARK:- Flow Layout
extension MPHomeViewController : UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        var cellWidth = CGFloat()
        
//        if UserDefaults.standard.bool(forKey: "isDeviceiPhoneNotch") && UIDevice.current.orientation.isLandscape {
//            cellWidth = screenWidth / 2 - 60
//        } else if UserDefaults.standard.bool(forKey: "isDeviceiPhoneNotch") && UIDevice.current.orientation.isPortrait {
//            cellWidth = screenWidth / 2 - 16
//        } else {
//            cellWidth = screenWidth / 3 - 90
//        }
//        let cellHeight = cellWidth * 1.5
//        return CGSize(width: cellWidth, height: cellHeight)
        cellWidth = screenWidth / 2 - 20
        let cellHeight = cellWidth * 1.3 + 40
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


//MARK:- With Paginated Approach, fetching APIs
extension MPHomeViewController {
    
    func loadNextPage() {
        let temp = NetworkServer()
        temp.apiCall(page: page) { (search, error) in
            
            if let error = error {
                print("Get  error: \(error.localizedDescription)")
                return
            }
            guard let search = search  else { return }
            
            for item in search.Search {
                var movieData = [String : String]()
                movieData.updateValue(item.title, forKey: "title")
                movieData.updateValue(item.type, forKey: "type")
                movieData.updateValue(item.imdbID, forKey: "imdbID")
                movieData.updateValue(item.year, forKey: "year")
                movieData.updateValue(item.poster, forKey: "poster")
                self.moviesData.append(movieData)
            }
           
            // Updating UI on main thread
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
}
