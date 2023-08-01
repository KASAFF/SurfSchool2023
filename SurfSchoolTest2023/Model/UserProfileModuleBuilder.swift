//
//  UserProfileModuleBuilder.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class UserProfileModuleBuilder {

    lazy private var networkService: INetworkService = {
        return MockNetworkService()
    }()

    lazy private var persistanceService: IPersistanceManager = {
        return PersistanceManager()
    }()

    func build() -> UIViewController {
        let presenter = UserProfilePresenter(networkService: networkService, persistanceService: persistanceService)
        let viewController = UserProfileViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
