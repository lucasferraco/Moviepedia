//
//  NetworkWorker.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 27/08/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkWorkerError: Error {
	case NoConnection
	case MalformedURL
	case MalformedData
	case Failure
}

class NetworkWorker {
	
	/// Makes a HTTP GET request and retrieves its decodable data.
	///
	/// - Parameters:
	///   - urlString: The string representing the complete URL path.
	///   - parameters: The parameters.
	///   - headers: The headers.
	///   - completion: The handler to be called once the request has finished.
	public func get<T>(from urlString: String, with parameters: [String : Any]? = nil, headers: [String : String]? = nil, _ completion: @escaping (T?, NetworkWorkerError?) -> Void) where T : Decodable {
		guard hasConnection() else {
			return completion(nil, .NoConnection)
		}
		
		if let url = URL(string: urlString) {
			Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
				.validate()
				.responseJSON { (response) in
					guard response.result.isSuccess else {
						completion(nil, .Failure)
						return
					}
					
					guard let decodableData = response.result.value as? T else {
						completion(nil, .MalformedData)
						return
					}
					
					completion(decodableData, nil)
			}
		} else {
			completion(nil, .MalformedURL)
		}
	}
	
	/// Downloads the contents of the specified URL.
	///
	/// - Parameters:
	///   - urlString: The string representing the complete URL path.
	///   - completion: The handler to be called once the request has finished.
	public func download(from urlString: String, _ completion: @escaping (Data?, NetworkWorkerError?) -> Void) {
		guard hasConnection() else {
			return completion(nil, .NoConnection)
		}
		
		if let url = URL(string: urlString) {
			Alamofire.download(url)
				.validate()
				.responseData { (response) in
					guard response.result.isSuccess else {
						completion(nil, .Failure)
						return
					}
					
					guard let data = response.result.value else {
						completion(nil, .MalformedData)
						return
					}
					
					completion(data, nil)
			}
		} else {
			completion(nil, .MalformedURL)
		}
	}
	
	//MARK:- Auxiliary methods
	
	/// Verify if the network is currently reachable.
	///
	/// - Returns: Whether the network is currently reachable.
	private func hasConnection() -> Bool {
		if let connectionManager = Alamofire.NetworkReachabilityManager() {
			return connectionManager.isReachable
		}
		
		return false
	}
}
