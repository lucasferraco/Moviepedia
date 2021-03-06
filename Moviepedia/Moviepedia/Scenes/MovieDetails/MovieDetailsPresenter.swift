//
//  MovieDetailsPresenter.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 30/08/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsPresentationLogic {
	func presentMovieDetails(with response: MovieDetails.ShowMovieDetails.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic {
	weak var viewController: MovieDetailsDisplayLogic?
	
	//MARK:- MovieDetailsPresentationLogic
	
	func presentMovieDetails(with response: MovieDetails.ShowMovieDetails.Response) {
		let movie = response.movie
		
		var movieTitle = ""
		if let title = movie.title {
			movieTitle = title
		} else if let originalTitle = movie.originalTitle {
			movieTitle = originalTitle
		}
		
		var genresString = ""
		if let genreIds = movie.genreIds {
			let genreIdsReduced = genreIds.reduce(into: "", { (genresString, id) in
				if let genreName = response.genres?[id] {
					genresString += genreName + ", "
				}
			}).dropLast(2)
			
			genresString = String(genreIdsReduced)
		}
		
		var releaseDate = ""
		if let dateObj = movie.releaseDate {
			releaseDate = DateFormatter.localizedString(from: dateObj, dateStyle: .short, timeStyle: .none)
		}
		
		let image = response.backgroundImage ?? #imageLiteral(resourceName: "defaultMovieImage.png")
		
		let movieInfo = MovieDetails.MovieInfo(title: movieTitle, releaseDate: releaseDate, genres: genresString, overview: movie.overview)
		let viewModel = MovieDetails.ShowMovieDetails.ViewModel(movieInfo: movieInfo, backgroundImage: image)
		viewController?.displayMovieInfo(with: viewModel)
	}
}
