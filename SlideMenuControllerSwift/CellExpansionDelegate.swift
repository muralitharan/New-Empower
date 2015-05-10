//
//  GoalActionCellExpansionDelegate.swift
//  AlwaysOn
//
//  Created by Jawwad Ahmad on 9/11/14.
//  Copyright (c) 2014 Onlife Health. All rights reserved.
//

import UIKit

class CellExpansionDelegate {

    private(set) var indexPathForExpandedRow: NSIndexPath? = nil

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var pathsToReload = [indexPath]

        if let previouslyExpandedRowIndexPath = indexPathForExpandedRow {
            if indexPath == previouslyExpandedRowIndexPath {
                indexPathForExpandedRow = nil
            } else {
                indexPathForExpandedRow = indexPath
                pathsToReload.append(previouslyExpandedRowIndexPath)
            }
        } else {
            indexPathForExpandedRow = indexPath
        }

        tableView.reloadRowsAtIndexPaths(pathsToReload, withRowAnimation: .Automatic)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
    }

}
