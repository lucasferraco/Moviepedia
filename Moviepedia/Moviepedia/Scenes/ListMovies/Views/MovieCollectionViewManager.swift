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
	func getMoreMovies(_ completion: @escaping ([ListMovies.DisplayableMovieInfo]) -> Void)
	func didSelectMovie(with id: Int)
}

class MovieCollectionViewManager: NSObject {
	
	fileprivate let defaultPadding: CGFloat = 20.0
	
	private var data: [[ListMovies.DisplayableMovieInfo]] = [[]]
	private var collectionView: UICollectionView!
	private var currentSection = 0
	
	var delegate: MovieCollectionViewManagerProtocol?
	
	init(of collection: UICollectionView) {
		super.init()
		collection.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
		collectionView = collection
	}
	
	//MARK:- Public Methods
	
	public func display(movies: [ListMovies.DisplayableMovieInfo]) {
		data[0] = movies
		collectionView.reloadData()
	}
}

//MARK:- UICollectionViewDataSource

extension MovieCollectionViewManager: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data[section].count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell			 else {
			return UICollectionViewCell()
		}
		
		let currentMovieInfo = data[indexPath.section][indexPath.row]
		movieCell.configure(with: currentMovieInfo)
		delegate?.getImageForMovie(with: currentMovieInfo) { (image) in
			movieCell.setBackground(with: image)
		}
		
		return movieCell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		let seventyPercent = Double(data[indexPath.section].count) * 0.7
		
		if Double(indexPath.row) >= seventyPercent {
			delegate?.getMoreMovies() { (newMovies) in
				self.data.append(newMovies)
				self.currentSection += 1
				
				self.collectionView.insertSections([self.currentSection])
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.didSelectMovie(with: data[indexPath.section][indexPath.row].id)
	}
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
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
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
