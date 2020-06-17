

import Foundation
import Alamofire

//let BASEURL = Bundle.main.infoDictionary?["ServerName"] as! String

let BaseURL = "https://192.168.1.5:3001"

enum URLs: APIConfiguration {
    
    case transaction(body: Data)


    var METHOD: HTTPMethod {
        switch self {
        case .transaction:
            return .post
//        default:
//            return .get
        }
    }

    var FULL_PATH_URL: String {
        switch self {
        case .transaction:
            return BaseURL + "/blockchain/transactions"
        }
    }

    var PARAMETERS: Parameters?
    {
        switch self {

        default:
            return nil
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
        case .transaction(let body):
            urlRequest.httpBody = body
        }
        

//        switch self {
//
//        default:
////            urlRequest.setValue(NetworkConstant.ContentType.json, forHTTPHeaderField: NetworkConstant.HTTPHeaderField.contentType)
//        }

        
        urlRequest.httpMethod = METHOD.rawValue


        Log.i("Request => \(urlRequest)")
        Log.i("Request All Headers => \(urlRequest.allHTTPHeaderFields!)")
        
        return urlRequest

   }
}
