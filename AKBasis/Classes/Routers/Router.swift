//
//  Router.swift
//  applicant
//
//  Created by Алексей Коньшин on 03.04.17.
//  Copyright © 2017 SuperJob. All rights reserved.
//

import UIKit

/// Протокол для всех роутеров
public protocol Router {
    
    /// Тип рутового контроллера
    associatedtype RootController: UIViewController
    /// Тип рутового контроллера
    associatedtype Assembler: Assembly
    
    /// Основополагающий контроллер для роутера, например, UINavigationController
    var rootController: RootController { get }
    /// сборщик
    var assembler: Assembler { get }
    
    /// Убирает все открытые экраны
    func clear()
    
    /// Открыть контроллер
    func routeTo(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension Router {
    
    /// Отобразить контроллер модально
    public func present(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        rootController.present(vc, animated: animated, completion: completion)
    }
    
}

extension Router where RootController: UINavigationController {
    
    public func clear() {
        rootController.viewControllers = []
    }
    
    /// Открыть контроллер
    public func routeTo(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        rootController.pushViewController(vc, animated: animated)
        completion?()
    }
}