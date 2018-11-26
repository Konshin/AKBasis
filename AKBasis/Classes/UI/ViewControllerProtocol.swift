//
//  ViewControllerProtocol.swift
//  ToDo
//
//  Created by Aleksey on 20.09.17.
//  Copyright © 2017 Aleksey. All rights reserved.
//

import UIKit

/// Протокол, объединящий сущность, являющиеся неким представлением от UIViewController
public protocol ViewControllerProtocol: class {

    /// Сущность в виде UIViewController
    var asViewController: UIViewController { get }
}

// MARK: - С вьюконтроллером все просто
extension UIViewController: ViewControllerProtocol {
    
    public var asViewController: UIViewController {
        return self
    }
}
