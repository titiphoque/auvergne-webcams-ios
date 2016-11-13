//
//  DefaultsKeyExtension.swift
//  filesdnd
//
//  Created by Drusy on 01/11/2016.
//  Copyright © 2016 Files Drag & Drop. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    static let firstConfigurationDone = DefaultsKey<Bool>("firstConfigurationDone")
    static let isDarkTheme = DefaultsKey<Bool>("darkTheme")
    static let shouldAutorefresh = DefaultsKey<Bool>("autorefresh")
    static let autorefreshInterval = DefaultsKey<Double>("autorefreshInterval")
}
