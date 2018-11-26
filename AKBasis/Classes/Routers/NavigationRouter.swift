//
//  CommonNavigationRouter.swift
//  applicant
//
//  Created by Konshin on 30.10.17.
//  Copyright © 2017 SuperJob. All rights reserved.
//

import UIKit

/// Стандартный роутер с навигацией
public class NavigationRouter<T: Assembly>: Router {
    
    /// Тип рутового контроллера
    public typealias RootController = UINavigationController
    /// Тип сборщика
    public typealias Assembler = T
    
    /// Контроллер навигации
    unowned let navigationController: UINavigationController
    /// Хранилище зависимостей
    public let assembler: T
    
    public init(assembler: Assembler,
         navigationController: UINavigationController) {
        self.assembler = assembler
        self.navigationController = navigationController
        navigationController.router = self
    }
    
    /// Рутовый контроллер
    public var rootController: RootController {
        return navigationController
    }
}
