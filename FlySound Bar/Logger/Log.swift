//
//  Created by Edward Nagy on 28/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation
import SwiftyBeaver

public var log: SwiftyBeaver.Type = {
  var beaverLog = SwiftyBeaver.self
  let console = ConsoleDestination()
  let file = FileDestination()

  file.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $N.$F():$l $L: $M"
  let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"

  file.logFileURL = URL(string: documentDirectoryUrl.absoluteString + "TripPlanner-" + appVersion + ".log")

  console.levelColor.error = "❌ "
  console.levelColor.warning = "⚠️ "
  console.levelColor.info = "🔵 "
  console.levelColor.debug = "⚪️ "
  console.levelColor.verbose = " "

  beaverLog.addDestination(console)
  beaverLog.addDestination(file)

  return beaverLog
}()
