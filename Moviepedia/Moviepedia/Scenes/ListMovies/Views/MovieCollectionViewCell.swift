//
//  MovieCollectionViewCell.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 29/08/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellProtocol {
	func setBackground(with image: UIImage)
}

class MovieCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "MovieCollectionViewCell"
	static let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: Bundle.main)
	
	static let preferredSize = CGSize(width: 300, height: 407)

	@IBOutlet weak fileprivate var backgroundImageView: UIImageView!
	@IBOutlet weak fileprivate var titleLabel: UILabel!
	@IBOutlet weak fileprivate var releaseDateLabel: UILabel!
	@IBOutlet weak fileprivate var genresLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		setup()
		setBackground(with: #imageLiteral(resourceName: "defaultMovieImage.png"))
	}
	
	//MARK:- Public Methods and variables
	
	public func configure(with info: ListMovies.DisplayableMovieInfo) {
		titleLabel.text = info.title
		releaseDateLabel.text = info.releaseDate
		genresLabel.text = info.genre
		
		if let image = info.image {
			setBackground(with: image)
		}
	}

	//MARK:- Auxiliary Methods
	
	private func setup() {
		layer.cornerRadius = 15.0
		titleLabel.withShadow()
		releaseDateLabel.withShadow()
		genresLabel.withShadow()
	}
}

extension MovieCollectionViewCell: MovieCollectionViewCellProtocol {
	func setBackground(with image: UIImage) {
		backgroundImageView.image = image.withOverlay()
	}
}
