//
//  TweetTableViewCellDelegate.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//

import Foundation

protocol TweetTableViewCellDelegate: AnyObject {
    func tweettableViewCellDidTapLike()
    func tweettableViewCellDidTapRetweet()
    func tweettableViewCellDidTapReply()
    func tweettableViewCellDidTapShare()
}
