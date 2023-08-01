//
//  CustomFlowLayout.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

class SkillsCustomFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 8.0
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 0, bottom: 0.0, right: 0)
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        var updatedAttributes: [UICollectionViewLayoutAttributes] = []

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            guard let updatedAttribute = layoutAttribute.copy() as? UICollectionViewLayoutAttributes else { return }
            updatedAttribute.frame.origin.x = leftMargin
            updatedAttributes.append(updatedAttribute)
            leftMargin += updatedAttribute.frame.width + cellSpacing
            maxY = max(updatedAttribute.frame.maxY, maxY)
        }
        return updatedAttributes
    }
}

