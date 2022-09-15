//
//  BaseViewController.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/09/15.
//

import Foundation
import UIKit

class BaseViewController:
    LifecycleInjectableViewController,
    SwinjectSupport,
    UseEffectSupport,
    APIHandler {}

typealias OwnerVC = SwinjectSupport & UseEffectSupport & APIHandler
