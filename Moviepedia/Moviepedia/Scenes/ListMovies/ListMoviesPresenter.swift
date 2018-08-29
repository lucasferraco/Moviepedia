//
//  ListMoviesPresenter.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 29/08/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListMoviesPresentationLogic {
	func presentSomething(response: ListMovies.Something.Response)
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
	weak var viewController: ListMoviesDisplayLogic?
	
	// MARK: Do something
	
	func presentSomething(response: ListMovies.Something.Response) {
		let viewModel = ListMovies.Something.ViewModel()
		viewController?.displaySomething(viewModel: viewModel)
	}
}
