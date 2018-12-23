//
//  AlertPresenter.swift
//  receipe
//
//  Created by Konshin on 02.08.17.
//  Copyright © 2017 alekoleg. All rights reserved.
//

import UIKit

/// Протокол объекта, который умеет отображать UIAlertController
public protocol AlertPresenter: class {
    
    /// Конфигураторы текстфилда
    typealias TextFieldConfiguration = (UITextField) -> Void
    
    /// Отображает алерт с заданием всех параметров
    func presentAlert(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style,
                      actions: [UIAlertAction],
                      textfieldConfigurations: [TextFieldConfiguration])
}

extension AlertPresenter where Self: ViewControllerProtocol {
    
    /// Отображает алерт с заданием всех параметров
    public func presentAlert(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style,
                      actions: [UIAlertAction],
                      textfieldConfigurations: [TextFieldConfiguration]) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
        actions.forEach(alertController.addAction)
        textfieldConfigurations.forEach(alertController.addTextField)
        asViewController.present(alertController, animated: true)
    }
    
}

/// Дефолтный экшен закрытия
private let closeAction = UIAlertAction(title: Bundle(identifier: "com.apple.UIKit")?
    .localizedString(forKey: "Close",
                     value: "",
                     table: nil),
                                        style: .cancel,
                                        handler: nil)

// MARK: - Default realization
extension AlertPresenter {
    
    /// Стандартный экшен закрытия
    public var defaultCloseAction: UIAlertAction {
        return closeAction
    }
    
    /// Отображает алерт с единственной кнопкой - закрыть
    public func presentAlert(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style = .alert,
                      actions: [UIAlertAction]? = nil) {
        presentAlert(title: title,
                     message: message,
                     preferredStyle: preferredStyle,
                     actions: actions ?? [defaultCloseAction],
                     textfieldConfigurations: [])
    }
    
    /// Отображает алерт контроллер в стиле - алерт
    public func presentAlert(title: String?,
                      message: String?,
                      actions: [UIAlertAction],
                      textfieldConfigurations: [TextFieldConfiguration] = []) {
        presentAlert(title: title,
                     message: message,
                     preferredStyle: .alert,
                     actions: actions,
                     textfieldConfigurations: textfieldConfigurations)
    }
}
