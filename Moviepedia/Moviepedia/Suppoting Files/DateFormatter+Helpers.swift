//
//  DateFormatter+Helpers.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 26/08/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

extension DateFormatter {
	static let yyyyMMddFormat: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.calendar = Calendar(identifier: .iso8601)
		return formatter
	}()
}
