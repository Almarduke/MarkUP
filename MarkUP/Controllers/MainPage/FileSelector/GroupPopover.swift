//
//  DirectoryManager.swift
//  MarkUP
//
//  Created by Midrash Elucidator on 2019/4/30.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

extension FileSelectorVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case StoryboardKey.ShowGroupSelector:
            let navigation = segue.destination as! UINavigationController
            let groupSelectorVC = navigation.viewControllers.first as! GroupSelectorVC
            let popoverController = navigation.popoverPresentationController
            groupSelectorVC.fileSelectorVC = self
            popoverController?.delegate = self
        default:
            return
        }
    }
    
    func createGroup(alertOwner: UIViewController) {
        let success = GroupManager.createGroup(inputTextField.text!)
        if success {
            currentGroup = inputTextField.text!
            fileList = MarkdownManager.loadFiles(inGroup: currentGroup)
            collectionView.reloadData()
            let owner = alertOwner as! GroupSelectorVC
            owner.groupList = GroupManager.loadGroups()
            owner.tableView.reloadData()
            owner.resetSize()
        } else {
            let alert = UIAlertController(
                title: LocalizationKey.DuplicateGroupName,
                message: "",
                preferredStyle: .alert
            )
            alert.addAction(.init(
                title: LocalizationKey.Yes,
                style: .default))
            alertOwner.present(alert, animated: true, completion: nil)
        }
    }
}
