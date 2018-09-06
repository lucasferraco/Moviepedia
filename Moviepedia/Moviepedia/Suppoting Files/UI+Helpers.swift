//
//  UI+Helpers.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 30/08/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

extension UIView {
	public func withShadow() {
		let layer = self.layer
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.8
		layer.shadowOffset = CGSize(width: -2, height: 4)
		layer.shadowRadius = 2
		layer.shadowPath = nil
	}
}

extension UIImage {
	public func withOverlay() -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		let renderer = UIGraphicsImageRenderer(size: size)
		
		return renderer.image { ctx in
			// fill the background with white so that translucent colors get lighter
			UIColor.lightGray.set()
			ctx.fill(rect)
			
			draw(in: rect, blendMode: .multiply, alpha: 1)
		}
	}
}
