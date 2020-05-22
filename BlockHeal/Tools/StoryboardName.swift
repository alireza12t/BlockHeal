
import UIKit

enum StoryboardName: String {
    case Main, UserAction


    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T : UIViewController>(viewControllerClass: T.Type) -> T {
        Log.i()

        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID

        return self.instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

    func initialViewController() -> UIViewController? {
        Log.i()

        return instance.instantiateInitialViewController()
    }
}
