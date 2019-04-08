//
//  RemovingRouter.swift
//  applicant
//
//  Created by Алексей Коньшин on 15.05.17.
//  Copyright © 2017 SuperJob. All rights reserved.
//

import UIKit

/// Протокол роутера, умеющего убирать контроллеры из стека отображения
public protocol RemovingScreensRouter {
    /// Возвращает фокус на контроллер. Удаляет все контроллеры из стека, отображенные после данного контроллера
    ///
    /// - Parameters:
    ///   - controller: Контроллер, на который надо перейти
    ///   - animated: Анимационно
    ///   - completion: блок завершения
    func returnToController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    /// Убирает все контроллера заданных типов из стека отображаемых контроллеров
    ///
    /// - Parameter types: Список типов для убирания
    func removeControllerTypesFromStack(_ types: [AnyClass])
    
    /// Удаляет контроллер и все контроллеры из стека после него
    ///
    /// - Parameters:
    ///   - controller: Контроллер для удаления
    ///   - animated: Анимационно
    func removeControllerAndAllFollowing(_ controller: UIViewController, animated: Bool)
    
    /// Возвращает стек к рутовому контроллеру
    ///
    /// - Parameter animated: Анимационно
    func returnToRootController(animated: Bool)
    
    /// Удаляет вьюконтроллер из стека навигации, если он там есть
    ///
    /// - Parameters:
    ///   - controller: Контроллер для убирания
    ///   - animated: Анимационно?
    func removeController(_ controller: UIViewController, animated: Bool)
}

extension Router where Self: RemovingScreensRouter, RootController: UINavigationController {
    
    public func returnToController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if rootController.viewControllers.contains(controller) {
            if rootController.viewControllers.last != controller {
                CATransaction.begin()
                CATransaction.setCompletionBlock(completion)
                rootController.popToViewController(controller, animated: animated)
                removePresetedComntrollers(animated: animated, completion: nil)
                CATransaction.commit()
            } else {
                removePresetedComntrollers(animated: animated) { _ in
                    completion?()
                }
            }
        } else {
            controller.presentedViewController?.dismiss(animated: animated, completion: completion)
        }
    }
    
    public func removeControllerAndAllFollowing(_ controller: UIViewController, animated: Bool) {
        if let index = rootController.viewControllers.firstIndex(of: controller) {
            if index > 0 {
                // Возвращаем до предыдущего контроллера
                rootController.popToViewController(rootController.viewControllers[index-1],
                                                   animated: animated)
            } else {
                // Убираем все контроллеры
                rootController.setViewControllers([], animated: animated)
            }
        } else if controller.presentingViewController == rootController {
            controller.dismiss(animated: animated, completion: nil)
        }
    }
    
    /// Удаляет вьюконтроллер из стека навигации, если он там есть
    ///
    /// - Parameters:
    ///   - controller: Контроллер для убирания
    ///   - animated: Анимационно?
    public func removeController(_ controller: UIViewController, animated: Bool) {
        if let index = rootController.viewControllers.firstIndex(of: controller) {
            var viewControllers = rootController.viewControllers
            viewControllers.remove(at: index)
            rootController.setViewControllers(viewControllers, animated: animated)
        }
    }
    
    /// Возвращает стек к рутовому контроллеру
    ///
    /// - Parameter animated: Анимационно
    public func returnToRootController(animated: Bool) {
        rootController.popToRootViewController(animated: animated)
        removePresetedComntrollers(animated: animated, completion: nil)
    }
    
    public func removeControllerTypesFromStack(_ types: [AnyClass]) {
        // Удаляем из презентед
        removePresentedController(fromController: rootController,
                                  of: types,
                                  animated: false,
                                  completion: nil)
        // Удаляем из стека
        rootController.viewControllers = rootController.viewControllers.filter { vc in
            for type in types where vc.isKind(of: type) {
                return false
            }
            return true
        }
    }
    
    // MARK: - private
    
    /// Убирает показанный модально контроллер, если он есть
    ///
    /// - Parameters:
    ///   - animated: Анимационно
    ///   - completion: Блок завершения. Вызывается с булькой - был ли убрал контроллер
    private func removePresetedComntrollers(animated: Bool, completion: ((Bool) -> Void)?) {
        removePresentedController(fromController: rootController,
                                  of: nil,
                                  animated: animated,
                                  completion: completion)
    }
    
    /// Убирает показанный модально контроллер, если он есть и его тип совпадает с заданным
    ///
    /// - Parameters:
    ///   - fromController: С какого контроллера убирать
    ///   - types: Список типов контроллеров, которые стоит убрать. Если ничего не передать - уберёт любой контроллер
    ///   - animated: Анимационно
    ///   - completion: Блок завершения. Вызывается с булькой - был ли убрал контроллер
    private func removePresentedController(fromController: UIViewController,
                                           of types: [AnyClass]?,
                                           animated: Bool,
                                           completion: ((Bool) -> Void)?) {
        if let presented = fromController.presentedViewController {
            let completion = completion
            
            if let types = types {
                var isSuccess = false
                for type in types where presented.isKind(of: type) {
                    isSuccess = true
                    presented.dismiss(animated: animated) {
                        completion?(true)
                    }
                }
                removePresentedController(fromController: presented,
                                          of: types,
                                          animated: animated) { newSuccess in
                                            completion?(newSuccess || isSuccess)
                }
            } else {
                presented.dismiss(animated: animated) {
                    completion?(true)
                }
            }
        } else {
            completion?(false)
        }
    }
}
