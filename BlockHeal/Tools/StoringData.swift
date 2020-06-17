//
//  StoringData.swift
//  BlockHeal
//
//  Created by ali on 6/17/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import Foundation



enum UserDefaultKeys:String {
    case Token
    case IsFaceIdEnabled
    case PrivateKey
    case keyboardDistances
    case PublicKey
}



class StoringData {
    
    static var isFaceIdEnabled:Bool {
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.IsFaceIdEnabled.rawValue)
        }
        set (newValue) {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.IsFaceIdEnabled.rawValue)
        }
    }
    
    static var token: String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.Token.rawValue) ?? ""
        }
        set (newValue) {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.Token.rawValue)
        }
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    static var keyboardDistances:[String:Any]? {
        get {
            return UserDefaults.standard.dictionary(forKey: UserDefaultKeys.keyboardDistances.rawValue)
        }
        set (newValue) {
            if let dictionary =  UserDefaults.standard.dictionary(forKey: UserDefaultKeys.keyboardDistances.rawValue) {
                var changedDictionary = dictionary
                changedDictionary["\(newValue!.keys.first!)"] = newValue!.values.first!
                UserDefaults.standard.setValue(changedDictionary, forKey: UserDefaultKeys.keyboardDistances.rawValue)
            }else{
                UserDefaults.standard.setValue(newValue!, forKey:UserDefaultKeys.keyboardDistances.rawValue )
            }
            
        }
    }

}
