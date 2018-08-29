//
//  MovieCollectionViewManager.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 29/08/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class MovieCollectionViewManager: NSObject, UICollectionViewDataSource {
	
	var data: [ListMovies.DisplayableMovieInfo]! = []
	
	init(of collection: UICollectionView) {
		collection.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
	}
	
	//MARK:- UICollectionViewDataSource
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		movieCell.configure(with: data[indexPath.row])
		
		return movieCell
	}
	
	
}

//MARK:- UICollectionViewDelegate

extension MovieCollectionViewManager: UICollectionViewDelegate {
	
}
