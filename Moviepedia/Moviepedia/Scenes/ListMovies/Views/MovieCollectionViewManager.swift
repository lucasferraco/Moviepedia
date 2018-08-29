//
//  MovieCollectionViewManager.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 29/08/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

protocol MovieCollectionViewManagerProtocol {
	func getImageForMovie(with movieInfo: ListMovies.DisplayableMovieInfo, _ completion: @escaping (UIImage) -> Void)
}

class MovieCollectionViewManager: NSObject, UICollectionViewDataSource {
	
	fileprivate let defaultPadding: CGFloat = 20.0
	
	var data: [ListMovies.DisplayableMovieInfo]! = []
	var delegate: MovieCollectionViewManagerProtocol?
	
	init(of collection: UICollectionView) {
		super.init()
		collection.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
		collection.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
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
		delegate?.getImageForMovie(with: data[indexPath.row]) { (image) in
			movieCell.setBackground(with: image)
		}
		
		return movieCell
	}
}

//MARK:- UICollectionViewDelegate

extension MovieCollectionViewManager: UICollectionViewDelegate {
	
}

//MARK:- UICollectionViewDelegateFlowLayout

extension MovieCollectionViewManager: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if UIDevice.current.userInterfaceIdiom == .phone, let layoutBounds = collectionViewLayout.collectionView?.bounds {
			if UIDevice.current.orientation == .portrait {
				return getProportionalSize(forWidth: layoutBounds.width - 2*defaultPadding)
			} else { // landscape
				return getProportionalSize(forHeight: layoutBounds.height - 2*defaultPadding)
			}
		}
		
		return MovieCollectionViewCell.preferredSize
	}
}

//MARK:- Auxiliary Methods

extension MovieCollectionViewManager {
	fileprivate func getProportionalSize(forWidth width: CGFloat) -> CGSize {
		let multiplier = width / MovieCollectionViewCell.preferredSize.width
		return CGSize(width: width, height: MovieCollectionViewCell.preferredSize.height * multiplier)
	}
	
	fileprivate func getProportionalSize(forHeight height: CGFloat) -> CGSize {
		let multiplier = height / MovieCollectionViewCell.preferredSize.height
		return CGSize(width: MovieCollectionViewCell.preferredSize.width * multiplier, height: height)
	}
}
