//
//  UIViewController+Router.swift
//  applicant
//
//  Created by alekoleg on 02/11/2017.
//  Copyright © 2017 SuperJob. All rights reserved.
//

import UIKit

// MARK: - Ссылка на текущий роутер у viewcontrollera
extension UIViewController {
    
    private struct AssociatedKeys {
        static var router = "router"
    }
    
    // роутер для VC
    var router: Any? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.router)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.router, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
