//
//  TMDbClient.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 28/08/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

class TMDbClient {
	
	internal let baseURL = "https://api.themoviedb.org/3"
	internal let apiKey = "1f54bd990f1cdfb230adb312546d765d"
	
	internal enum Parameter: String {
		case page 			= "page"
		case languageCode	= "language"
		case regionCode 	= "region"
	}
	
	internal func getParameters(_ options: Set<Parameter>, forPage page: Int? = nil) -> [String : Any] {
		var params: [String : Any] = [:]
		params.updateValue(apiKey, forKey: "api_key")
		
		for option in options {
			switch option {
			case .page:
				if let page = page {
					params.updateValue(page, forKey: "page")
				}
			case .languageCode:
				if let languageCode = currentLanguageCode() {
					params.updateValue(languageCode, forKey: "language")
				}
			case .regionCode:
				if let regionCode = currentRegionCode() {
					params.updateValue(regionCode, forKey: "region")
				}
			}
		}
		
		return params
	}
	
	//MARK:- Auxiliary Methods
	
	private func currentLanguageCode() -> String? {
		let currentLocale = Locale.current
		return currentLocale.languageCode
	}
	
	private func currentRegionCode() -> String? {
		let currentLocale = Locale.current
		return currentLocale.regionCode
	}
}
