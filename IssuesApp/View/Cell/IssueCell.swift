//
//  IssueCell.swift
//  IssuesApp
//
//  Created by hyunsu han on 2017. 11. 4..
//  Copyright © 2017년 hyunsu han. All rights reserved.
//

import UIKit

class IssueCell: UICollectionViewCell {
    @IBOutlet var stateButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var commentCountButton: UIButton!
}


extension IssueCell {
    
    static var cellFromNib: IssueCell {
        guard let cell = Bundle.main.loadNibNamed("IssueCell", owner: nil, options: nil)?.first as? IssueCell else { return IssueCell() }
        return cell
    }
    
    func update(data issue: Model.Issue) {
        titleLabel.text = issue.title
        let createdAt = issue.createdAt?.string(dateFormat: "dd MMM") ?? "-"
        contentLabel.text = "#\(issue.number) \(issue.state.rawValue) on \(createdAt) by \(issue.user.login)"
        stateButton.isSelected = issue.state == .closed
        commentCountButton.setTitle("\(issue.comments)", for: .normal)
        let commentCountHidden = issue.comments == 0
        commentCountButton.isHidden = commentCountHidden
    }
}

extension Date {
    func string(dateFormat: String, locale: String = "en-US") -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: locale)
        return format.string(from: self)
    }
}
