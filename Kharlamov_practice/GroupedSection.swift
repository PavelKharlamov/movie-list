//
//  GroupedSection.swift
//  Kharlamov_practice
//
//  Created by practice on 04.10.2019.
//  Copyright © 2019 Kharlamov. All rights reserved.
//

import Foundation

struct GroupedSection<SectionItem : Hashable, RowItem> {
    
    var sectionItem : SectionItem
    var rows : [RowItem]
    
    static func group(rows : [RowItem], by criteria : (RowItem) -> SectionItem) -> [GroupedSection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: rows, by: criteria)
        return groups.map(GroupedSection.init(sectionItem:rows:))
    }
    
}
