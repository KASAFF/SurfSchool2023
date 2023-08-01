//
//  PersistanceManager.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

protocol IPersistanceManager {
    func saveUser(user: User) throws
    func fetchUser() throws -> User?
}

final class PersistanceManager: IPersistanceManager {
    
    func saveUser(user: User) throws {
        let data = try JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: "firstUser")
    }

    func fetchUser() throws -> User? {
        guard let data = UserDefaults.standard.object(forKey: "firstUser") as? Data else { return nil  }

        let decodedUser = try JSONDecoder().decode(User.self, from: data)

        return decodedUser
    }
}
