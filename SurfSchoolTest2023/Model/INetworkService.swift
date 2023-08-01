//
//  INetworkService.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

protocol INetworkService {
    func getUserData(completion: @escaping (User) -> ())
}
