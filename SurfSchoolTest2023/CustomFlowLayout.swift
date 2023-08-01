//
//  CustomFlowLayout.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

class SkillsCustomFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach { attributes in
            if attributes.representedElementCategory == .cell {
                updateCellAttributes(attributes)
            }
        }
        return layoutAttributes
    }

    private func updateCellAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        let inset = collectionView.contentInset.left + collectionView.contentInset.right
        let availableWidth = collectionView.bounds.width - inset - sectionInset.left - sectionInset.right

        let indexPath = attributes.indexPath
        if let cell = collectionView.cellForItem(at: indexPath) as? SkillsCollectionViewCell {
            let labelWidth = cell.skillLabel.intrinsicContentSize.width
            let labelHeight = cell.skillLabel.intrinsicContentSize.height
            let cellWidth = min(availableWidth, labelWidth + 16) // Add some padding
            attributes.frame.size = CGSize(width: cellWidth, height: labelHeight + 16) // Add some vertical padding
        }
    }
}


