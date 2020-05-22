//
//  APIConfiguration.swift
//  GTalogue
//
//  Created by negar on 99/Farvardin/13 AP.
//  Copyright © 1399 negar. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var METHOD: HTTPMethod { get }
    var FULL_PATH_URL: String { get }
    var PARAMETERS: Parameters? { get }
}
