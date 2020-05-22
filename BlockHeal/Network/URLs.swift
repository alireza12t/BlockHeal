

import Foundation
import Alamofire

//let BASEURL = Bundle.main.infoDictionary?["ServerName"] as! String

let BaseURL = ""

enum URLs: APIConfiguration {



    var METHOD: HTTPMethod {
        switch self {
            
        default:
            return .get
        }
    }

    var FULL_PATH_URL: String {
        return ""
//        switch self {
//
//
//        }
    }

    var PARAMETERS: Parameters?
    {
        switch self {

        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {

        var urlRequest = URLRequest(url: try FULL_PATH_URL.asURL())
        var urlComponents = URLComponents(string: "\(urlRequest)")

        if let parameters = PARAMETERS {
            var param = [URLQueryItem]()
            parameters.keys.forEach({ (key) in param.append(URLQueryItem(name: key, value: "\(parameters[key]!)")) })
            urlComponents?.queryItems = param.reversed()

        }

        urlRequest = URLRequest(url: (urlComponents?.url)!)

        switch self {

        default:
            break
        }

        switch self {
       
        default:
            urlRequest.setValue(NetworkConstant.ContentType.json, forHTTPHeaderField: NetworkConstant.HTTPHeaderField.contentType)
        }

        
        urlRequest.httpMethod = METHOD.rawValue


        Log.i("Request => \(urlRequest)")
        Log.i("Request All Headers => \(urlRequest.allHTTPHeaderFields!)")
        
        return urlRequest

   }
}
