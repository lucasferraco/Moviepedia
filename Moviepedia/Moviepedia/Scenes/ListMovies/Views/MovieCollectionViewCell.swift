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
		addShadow(on: titleLabel)
		addShadow(on: releaseDateLabel)
		addShadow(on: genresLabel)
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
	}
	
	private func addShadow(on view: UIView) {
		let layer = view.layer
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.8
		layer.shadowOffset = CGSize(width: -2, height: 4)
		layer.shadowRadius = 2
		layer.shadowPath = nil
	}
	
	private func addOverlay(on image: UIImage) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
		let renderer = UIGraphicsImageRenderer(size: image.size)
		
		return renderer.image { ctx in
			// fill the background with white so that translucent colors get lighter
			UIColor.lightGray.set()
			ctx.fill(rect)
			
			image.draw(in: rect, blendMode: .multiply, alpha: 1)
		}
	}
}

extension MovieCollectionViewCell: MovieCollectionViewCellProtocol {
	func setBackground(with image: UIImage) {
		let finalImage = addOverlay(on: image)
		backgroundImageView.image = finalImage
	}
}
