//
//  NetworkDecodableWorker.swift
//  Moviepedia
//
//  Created by Lucas Ferraço on 27/08/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkDecodableWorkerError: Error {
	case NoConnection
	case MalformedData
	case Failed
}

class NetworkDecodableWorker {
	
	/// Makes a HTTP GET request and retrieves its decodable data.
	///
	/// - Parameters:
	///   - urlString: The String representing the complete URL path
	///   - parameters: The parameters.
	///   - headers: The headers.
	///   - completion: The handler to be called once the request has finished.
	public func get<T>(from urlString: String, with parameters: [String : Any]? = nil, headers: [String : String]? = nil, _ completion: @escaping ([T]?, NetworkDecodableWorkerError?) -> Void) where T : Decodable {
		guard hasConnection() else {
			return completion(nil, .NoConnection)
		}
		
		if let url = URL(string: urlString) {
			Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
				.validate()
				.responseJSON { (response) in
					guard response.result.isSuccess else {
						return completion(nil, .Failed)
					}
					
					guard let decodableData = response.result.value as? [T] else {
						return completion(nil, .MalformedData)
					}
					
					completion(decodableData, nil)
			}
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
