//
//  Created by Edward Nagy on 30/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

extension UIViewController {

  static var storyboard: UIStoryboard { UIStoryboard(name: "\(self)", bundle: Bundle(for: self)) }

  class func instantiate() -> Self { viewController(viewControllerClass: self) }

  var navEmbedded: UINavigationController { UINavigationController(rootViewController: self) }

  private static func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
    guard let scene = storyboard.instantiateInitialViewController() as? T
      else { fatalError("Could not find storyboard named: \(self) with initial view controller set.") }
    return scene
  }
}
