//
//  MovieCollectionViewCell.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 29/08/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "MovieCollectionViewCell"
	static let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: Bundle.main)

	@IBOutlet weak fileprivate var backgroundImageView: UIImageView!
	@IBOutlet weak fileprivate var titleLabel: UILabel!
	@IBOutlet weak fileprivate var releaseDateLabel: UILabel!
	@IBOutlet weak fileprivate var genresLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	public func configure(with info: ListMovies.DisplayableMovieInfo) {
		titleLabel.text = info.title
		releaseDateLabel.text = info.releaseDate
		genresLabel.text = info.genre
	}

}
