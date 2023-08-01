//
//  UserProfileModuleBuilder.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class UserProfileModuleBuilder {
    func build() -> UIViewController {
        let presenter = UserProfilePresenter()
        let viewController = UserProfileViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
