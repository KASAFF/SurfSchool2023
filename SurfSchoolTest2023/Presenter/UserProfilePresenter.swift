//
//  UserProfilePresenter.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

final class UserProfilePresenter: UserProfilePresenterProtocol {
    
    private let networkService: INetworkService
    
    private let persistanceService: IPersistanceManager
    
    init(
        networkService: INetworkService,
        persistanceService: IPersistanceManager
    ) {
        self.networkService = networkService
        self.persistanceService = persistanceService
    }
    
    private var loggedUser: User?
    
    weak var view: UserProfileViewProtocol?
    
    func getCountOfItems() -> Int {
        loggedUser?.skills.count ?? 0
    }
    
    func getTextOfSkill(of index: Int) -> String {
        return loggedUser?.skills[index] ?? ""
    }
    
    func viewLoaded() {
        do {
            loggedUser = try persistanceService.fetchUser()
        } catch {
            print("Failed to save user")
        }
        
        if loggedUser == nil {
            networkService.getUserData { [weak self] user in
                self?.loggedUser = user
                self?.view?.configure(with: user)
            }
        } else {
            guard let loggedUser else { return }
            self.view?.configure(with: loggedUser)
        }
    }
    
    func removeSkill(at index: Int) {
        loggedUser?.skills.remove(at: index)
        let indexPath = IndexPath(item: index, section: 0)
        view?.updateCollectionViewWithDeletion(at: indexPath)
        saveUser()
    }
    
    func addSkill(with name: String) {
        let indexPath = IndexPath(item: 0, section: 0)
        loggedUser?.skills.insert(name, at: 0)
        view?.updateCollectionViewWithAdditing(at: indexPath)
        saveUser()
    }

    private func saveUser() {
        guard let loggedUser else { return }
        do {
            try persistanceService.saveUser(user: loggedUser)
        } catch {
            print("Failed to save user")
        }
    }
    
}
