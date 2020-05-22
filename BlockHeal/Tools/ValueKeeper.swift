

import Foundation
import UIKit

enum UserType: String {
    case Doctor, Patient, DrugStore
}

///This class is definition of storing some internal Values
class ValueKeeper {
    
    
    
    ///App Language
    static var language: String = "EN"
    static var userType: UserType = .Doctor
    
}
