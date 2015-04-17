//
//  Menu.swift
//  MidnightBacon
//
//  Created by Justin Kolb on 11/2/14.
//  Copyright (c) 2014 Justin Kolb. All rights reserved.
//

import Foundation

struct MenuItem<A> {
    let title: String
    let action: A
}

class MenuGroup<A> {
    let title: String
    private var items = [MenuItem<A>]()

    init(title: String) {
        self.title = title
    }
    
    subscript(index: Int) -> MenuItem<A> {
        return items[index]
    }
    
    var count: Int {
        return items.count
    }
    
    func addItem(title: String, action: A) {
        items.append(MenuItem<A>(title: title, action: action))
    }
}

protocol MenuDataSource {
    func numberOfGroups() -> Int
    func numberOfItemsInGroup(group: Int) -> Int
    func titleForGroup(group: Int) -> String
    func titleForItemAtIndexPath(indexPath: NSIndexPath) -> String
    func triggerActionForItemAtIndexPath(indexPath: NSIndexPath)
}

class Menu<A> : MenuDataSource {
    var actionHandler: ((A) -> ())?
    private var groups = [MenuGroup<A>]()
    
    func addGroup(title: String) {
        groups.append(MenuGroup<A>(title: title))
    }

    func addItem(title: String, action: A) {
        groups.last!.addItem(title, action: action)
    }
    
    subscript(index: Int) -> MenuGroup<A> {
        return groups[index]
    }
    
    subscript(indexPath: NSIndexPath) -> MenuItem<A> {
        return groups[indexPath.section][indexPath.row]
    }
    
    var count: Int {
        return groups.count
    }

    
    // MARK: - MenuDataSource
    
    func numberOfGroups() -> Int {
        return count
    }
    
    func numberOfItemsInGroup(group: Int) -> Int {
        return self[group].count
    }
    
    func titleForGroup(group: Int) -> String {
        return self[group].title
    }
    
    func titleForItemAtIndexPath(indexPath: NSIndexPath) -> String {
        return self[indexPath].title
    }
    
    func triggerActionForItemAtIndexPath(indexPath: NSIndexPath) {
        if let actionHandler = self.actionHandler {
            actionHandler(self[indexPath].action)
        }
    }
}
