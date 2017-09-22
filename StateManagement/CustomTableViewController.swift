//
//  CustomTableViewController.swift
//  StateManagement
//
//  Created by Marcus Chandler on 22/09/2017.
//  Copyright © 2017 Marcus Chandler. All rights reserved.
//

import UIKit

class CustomTableViewController : UITableViewController, CustomTableViewCellDelegate {
    
    fileprivate var model : [[Bool]] = Array(repeating: Array(repeating: false, count: 3), count: 100)
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    internal override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row < model.count else { return CustomTableViewCell(state: Array(repeating: false, count: 3), delegate: self) }
        
        if let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableViewCell {
            cell.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.width, height: tableView.rowHeight))
            cell.setState(to: model[indexPath.row])
            cell.setDelegate(to: self)
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .darkGray
            return cell
        }
        else {
            let newCell : CustomTableViewCell = CustomTableViewCell(state: model[indexPath.row], delegate: self)
            newCell.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.width, height: tableView.rowHeight))
            newCell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .darkGray
            return newCell
        }
    }
    
    //# MARK:- CustomTableViewCellDelegate methods
    
    internal func stateDidChange(sender: CustomTableViewCell) -> Void {
        guard let indexPath : IndexPath = tableView.indexPath(for: sender) else { return }
        guard indexPath.row < model.count else { print("Error in \(#function) - cell index larger than model size!") ; return }
        
        print("CHANGING MODEL ROW [\(indexPath.row)] TO: \(sender.getState())")
        model[indexPath.row] = sender.getState()
        
        
    }
    
}
