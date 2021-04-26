//
//  CollapsableSection.swift
//  Checkist
//
//  Created by Amir Tutunchi on 2/21/21.
//  Copyright © 2021 jouritm. All rights reserved.
//

import Foundation
import Foundation

struct CollapsableSection {
    private(set) var sectionIndexPath: Int
    private(set) var isCollapsed: Bool
    
    init(withSection indexPath: Int, isCollapsed: Bool = false) {
        self.sectionIndexPath = indexPath
        self.isCollapsed = isCollapsed
    }
    
    mutating func toggleCollapseSection() {
        self.isCollapsed.toggle()
    }
}
