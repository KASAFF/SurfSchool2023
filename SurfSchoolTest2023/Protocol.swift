//
//  Protocol.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

//import UIKit
//
//public protocol CollectionCellAutoLayout: AnyObject {
//    var cachedSize: CGSize? { get set }
//}
//
//public extension CollectionCellAutoLayout where Self: UICollectionViewCell {
//
//    func preferredLayoutAttributes(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var newFrame = layoutAttributes.frame
//        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
//        layoutAttributes.frame = newFrame
//        cachedSize = newFrame.size
//        return layoutAttributes
//    }
//}
