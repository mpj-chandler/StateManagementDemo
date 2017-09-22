//
//  CustomTableView.swift
//  StateManagement
//
//  Created by Marcus Chandler on 22/09/2017.
//  Copyright © 2017 Marcus Chandler. All rights reserved.
//

import UIKit

class CustomTableView : UITableView {
    
    fileprivate var model : [(Int, Int, Int)]
    
    init(frame: CGRect, model: [(Int, Int, Int)]) {
        
        self.model = model
        
        super.init(frame: frame, style: .plain)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let model : [(Int, Int, Int)] = aDecoder.value(forKey: "model") as? [(Int, Int, Int)],
            let frame : CGRect = aDecoder.value(forKey: "frame") as? CGRect else { return nil }
    
        self.init(frame: frame, model: model)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.setValue(model, forKey: "model")
        aCoder.setValue(frame, forKey: "frame")
    }
    
    
}
