//
//  VerticalTopAlignLabel.swift
//  Bartani
//
//  Created by Rahman Fadhil on 27/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class VerticalTopAlignLabel: UILabel {
    override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }
        let attributedText = NSAttributedString(string: labelText)
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }

        super.drawText(in: newRect)
    }
}
