//
//  MockNetworkService.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

final class MockNetworkService: INetworkService {

    func getUserData(completion: @escaping (User) -> ()) {
        let user = User(name: "Иванов Иван Иванович", bio: "Middle iOS-разработчик, опыт более 2-х лет", location: "Воронеж", skills: [
            "Swift",
            "iOS",
            "UIKit",
            "SwiftUI",
            "Core Data",
            "Networking",
            "Keychain",
            "Auto Layout",
            "Git",
            "Debugging and testing",
            "ARC"
        ], description: "Experienced software engineer skilled in developing scalable and maintainable systems")
        completion(user)
    }
}
