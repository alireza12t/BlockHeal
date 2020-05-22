

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct EmptyResponse {
}

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}


class APIHelper {
    
//    static func LoginWithEmail_Password(username: String, password: String) -> Observable<Login> {
//        return request(URLs.Login(username: username, password: password))
//        //        return LoginRequest(URLs.Login(username: username, password: password))
//    }


    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        Log.i()
        
        return Observable<T>.create { observer  in
            _ = AF.request(urlConvertible, interceptor: NetworkInterceptor()).validate().responseDecodable
                { (response: DataResponse<T,AFError>) in
                    Log.i("REQUEST => \(String(describing: response.request))")
                    Log.i("STATUS CODE => \(String(describing: response.response?.statusCode))")
                    
                    switch response.result {
                    case .success(let value):
                        Log.i("SUCSESS => VALUE => \(String(describing: value))")
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        switch error {
                        case .responseSerializationFailed(let reason):
                            if case .inputDataNilOrZeroLength = reason  {
                                observer.onNext(EmptyResponse() as! T)
                                observer.onCompleted()
                            }
                            print(reason)
                            observer.onError(error)
                        default:
                            
                            if let data = response.data {
                                let responseJSON = try? JSON(data: data)
                                if let message: String = responseJSON?.dictionaryValue["messages"]?.arrayValue[0].stringValue {
                                    if !message.isEmpty {
                                        
                                        let customError = NSError(domain: message, code: response.response!.statusCode, userInfo: nil)
                                        Log.i("FAILURE => ERROR DESCRIPTION => \(String(describing: customError.domain))")
                                        observer.onError(customError)
                                        
                                    }
                                } else if let message: String = responseJSON?.dictionaryValue["error"]?.stringValue {
                                    if !message.isEmpty {
                                        let customError = NSError(domain: message, code: response.response!.statusCode, userInfo: nil)
                                        Log.i("FAILURE => ERROR DESCRIPTION => \(String(describing: customError.domain))")
                                        observer.onError(customError)
                                        
                                    }
                                }
                            }
                            
                            Log.i("FAILURE => ERROR DESCRIPTION => \(String(describing: error.errorDescription))")
                            observer.onError(error)
                            
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
