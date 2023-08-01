//
//  UserProfilePresenter.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

final class UserProfilePresenter: UserProfilePresenterProtocol {

    var networkService = MockNetworkService()

    private var loggedUser: User?

    weak var view: UserProfileViewProtocol?

    func getCountOfItems() -> Int {
        loggedUser?.skills.count ?? 0
    }

    func getTextOfSkill(of index: Int) -> String {
        return loggedUser?.skills[index] ?? ""
    }

    func viewLoaded() {
        loggedUser = networkService.getUserData()
    }

    func removeSkill(at index: Int) {
        loggedUser?.skills.remove(at: index)
        let indexPath = IndexPath(item: index, section: 0)
        view?.updateCollectionViewWithDeletion(at: indexPath)
    }

    func addSkill(with name: String) {
        let indexPath = IndexPath(item: 0, section: 0)
        loggedUser?.skills.insert(name, at: 0)
        view?.updateCollectionViewWithAdditing(at: indexPath)
    }
    
}
