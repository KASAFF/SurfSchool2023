//
//  User.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

struct User: Codable {
    let name: String
    let bio: String
    let location: String

    var skills: [String]

    let description: String
}
