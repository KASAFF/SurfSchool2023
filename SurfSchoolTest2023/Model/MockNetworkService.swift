//
//  MockNetworkService.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

final class MockNetworkService {

    func getUserData() -> User {
        return User(name: "Иванов Иван Иванович", bio: "Middle iOS-разработчик", location: "Воронеж", skills: [
            "Swift",
            "iOS",
            "UIKit",
            "SwiftUI",
            "Core Data",
            "Networking",
            "Keychain",
            "Auto Layout",
            "Git",
            "Debugging and testingDebugging and testingDebugging and testingDebugging and testing",
            "ARC"
        ], description: "Experienced software engineer skilled in developing scalable and maintainable systems")
    }
}
