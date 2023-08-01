//
//  UserProfileViewProtocol.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import Foundation

protocol UserProfileViewProtocol: AnyObject {
    func updateCollectionViewWithDeletion(at indexPath: IndexPath)
    func updateCollectionViewWithAdditing(at indexPath: IndexPath)
}
