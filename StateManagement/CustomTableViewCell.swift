//
//  CustomTableViewCell.swift
//  StateManagement
//
//  Created by Marcus Chandler on 22/09/2017.
//  Copyright © 2017 Marcus Chandler. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate {
    func stateDidChange(sender: CustomTableViewCell) -> Void
}

class CustomTableViewCell : UITableViewCell {
    
    fileprivate var switches : [UISwitch] = [UISwitch(), UISwitch(), UISwitch()]
    fileprivate var state : [Bool] = Array(repeating: false, count: 3) {
        didSet {
            if state != oldValue, let _ = delegate {
                delegate!.stateDidChange(sender: self)
            }
        }
    }
    fileprivate var delegate : CustomTableViewCellDelegate?
    
    init(state: [Bool], delegate: CustomTableViewCellDelegate) {
        
        self.state = state
        self.delegate = delegate
        
        super.init(style: .default, reuseIdentifier: "cell")
        
        configureSwitches()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let state : [Bool] = aDecoder.value(forKey: "state") as? [Bool],
            let delegate : CustomTableViewCellDelegate = aDecoder.value(forKey: "delegate") as? CustomTableViewCellDelegate else { return nil }
        
        self.init(state: state, delegate: delegate)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.setValue(state, forKey: "state")
        aCoder.setValue(delegate, forKey: "delegate")
    }
    
    
    internal func setDelegate(to delegate: CustomTableViewCellDelegate) -> Void {
        self.delegate = delegate
    }
    
    internal func setState(to newState: [Bool]) -> Void {
        state = newState
        configureSwitches()
        setNeedsDisplay()
    }
    
    internal func getState() -> [Bool] {
        return state
    }
    
    fileprivate func configureSwitches() -> Void {
        
        switches.forEach({
            if $0.isDescendant(of: self) {
                $0.removeFromSuperview()
            }
        })
        
        let switchWidth : CGFloat = bounds.width / 3
        
        for switchCount in 0 ..< switches.count {
            switches[switchCount].isOn = state[switchCount]
            switches[switchCount].addTarget(self, action: #selector(switched(sender:)), for: .valueChanged)
            switches[switchCount].frame = CGRect(origin: CGPoint(x: switchWidth * CGFloat(switchCount), y: 0),
                                                 size: CGSize(width: switchWidth, height: switches[switchCount].bounds.height))
        }
        
        switches.forEach({
            addSubview($0)
        })
    }
    
    @objc fileprivate func switched(sender: UISwitch) -> Void {
        
        guard let index : Int = switches.index(of: sender) else { return }
        
        state[index] = sender.isOn
        
    }
}
