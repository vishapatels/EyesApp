//
//  UICollectionView + ViewAnimator.swift
//  ViewAnimator
//
//  Created by Marcos Griselli on 15/04/2018.
//

import Foundation
import UIKit

public extension UICollectionView {

    /// VisibleCells in the order they are displayed on screen.
    var orderedVisibleCells: [UICollectionViewCell] {
        return indexPathsForVisibleItems.sorted().compactMap { cellForItem(at: $0) }
    }
    
    var evenCells: [UICollectionViewCell] {
        return indexPathsForVisibleItems.sorted().compactMap { ($0.row % 2 == 0) ? cellForItem(at: $0) : nil }
    }
    
    var oddCells: [UICollectionViewCell] {
        return indexPathsForVisibleItems.sorted().compactMap { ($0.row % 2 != 0) ? cellForItem(at: $0) : nil }
    }

    /// Gets the currently visibleCells of a section.
    ///
    /// - Parameter section: The section to filter the cells.
    /// - Returns: Array of visible UICollectionViewCells in the argument section.
    func visibleCells(in section: Int) -> [UICollectionViewCell] {
        return visibleCells.filter { indexPath(for: $0)?.section == section }
    }
}
