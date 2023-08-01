//
//  UserProfilePresenterProtocol.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

protocol UserProfilePresenterProtocol {
    func getCountOfItems() -> Int
    func removeSkill(at index: Int)
    func addSkill(with name: String)
    func getTextOfSkill(of index: Int) -> String
    func viewLoaded()
}
