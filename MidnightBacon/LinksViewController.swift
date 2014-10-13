//
//  LinksViewController.swift
//  MidnightBacon
//
//  Created by Justin Kolb on 10/2/14.
//  Copyright (c) 2014 Justin Kolb. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    struct Style {
        let backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        let foregroundColor = UIColor(white: 0.04, alpha: 1.0)
        let separatorColor = UIColor(white: 0.04, alpha: 0.2)
//        let backgroundColor = UIColor(white: 0.04, alpha: 1.0)
//        let foregroundColor = UIColor(white: 0.96, alpha: 1.0)
//        let separatorColor = UIColor(white: 0.96, alpha: 0.2)
//        let upvoteColor = UIColor(red: 0.98, green: 0.28, blue: 0.12, alpha: 1.0)
//        let downvoteColor = UIColor(red: 0.12, green: 0.28, blue: 0.98, alpha: 1.0)
        let upvoteColor = UIColor(red: 255.0/255.0, green: 139.0/255.0, blue: 96.0/255.0, alpha: 1.0) // ff8b60
        let downvoteColor = UIColor(red: 148.0/255.0, green: 148.0/255.0, blue: 255.0/255.0, alpha: 1.0) // 9494ff
    }
    
    var tableView: UITableView!
    let style = Style()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(LinkCell.self, forCellReuseIdentifier: "LinkCell")
        tableView.backgroundColor = style.backgroundColor
        tableView.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.separatorColor = style.separatorColor
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 0.0)
        
        view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LinkCell", forIndexPath: indexPath) as LinkCell
        cell.backgroundColor = style.backgroundColor
        cell.contentView.backgroundColor = style.backgroundColor
        cell.selectionStyle = .None
        cell.layoutMargins = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)

        if indexPath.row == 0 {
            cell.titleLabel.text = "TIL there is a $100 coin that is legal U.S. tender. They weigh1 ounce and are 99.95% platinum. This is the highest face value ever to appear on a U.S. coin."
        } else {
            cell.titleLabel.text = "TIL there is a $100 coin that is legal U.S."
        }
        cell.upvoteButton.setTitle("⬆︎", forState: .Normal)
        cell.upvoteButton.setTitleColor(style.upvoteColor, forState: .Normal)
        cell.upvoteButton.layer.cornerRadius = 4.0
        cell.upvoteButton.layer.borderWidth = 1.0
        cell.upvoteButton.layer.borderColor = style.upvoteColor.CGColor
        
        cell.downvoteButton.setTitle("⬆︎", forState: .Normal)
        cell.downvoteButton.transform = CGAffineTransformMakeScale(1.0, -1.0)
        cell.downvoteButton.setTitleColor(style.downvoteColor, forState: .Normal)
        cell.downvoteButton.layer.cornerRadius = 4.0
        cell.downvoteButton.layer.borderWidth = 1.0
        cell.downvoteButton.layer.borderColor = style.downvoteColor.CGColor
        
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .ByTruncatingTail
        cell.titleLabel.textColor = style.foregroundColor
        cell.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        let thumbnailData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("placeholderThumbnail", ofType: "jpg")!)
        let thumbnail = UIImage(data: thumbnailData!, scale: 2.0)
        cell.thumbnailImageView.image = thumbnail
        cell.thumbnailImageView.layer.masksToBounds = true
        cell.thumbnailImageView.layer.cornerRadius = 10.0
        cell.thumbnailImageView.layer.borderWidth = 1.0 / tableView.window!.screen.scale
        cell.thumbnailImageView.layer.borderColor = style.separatorColor.CGColor
        
        cell.commentsButton.setTitle("2000 Comments", forState: .Normal)
        cell.commentsButton.setTitleColor(style.separatorColor, forState: .Normal)
        cell.commentsButton.layer.cornerRadius = 4.0
        cell.commentsButton.layer.borderWidth = 1.0
        cell.commentsButton.layer.borderColor = style.separatorColor.CGColor
        cell.commentsButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
        
        return cell
    }

    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) -> [AnyObject]! {
        var moreAction = UITableViewRowAction(style: .Normal, title: "More") { (action, indexPath) -> Void in
            tableView.editing = false
            println("moreAction")
        }
        moreAction.backgroundColor = UIColor(red: 255.0/255.0, green: 87.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        var commentAction = UITableViewRowAction(style: .Default, title: "Comments") { (action, indexPath) -> Void in
            tableView.editing = false
            println("commentAction")
        }
        commentAction.backgroundColor = UIColor(red: 51.0/255.0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        
        return [moreAction, commentAction]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // If this isn't present the swipe doesn't work
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
