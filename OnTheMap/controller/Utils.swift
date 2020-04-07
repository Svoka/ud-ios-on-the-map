//
//  Utils.swift
//  OnTheMap
//
//  Created by Artem Osipov on 07/04/2020.
//  Copyright © 2020 Artem Osipov. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func showAlert(alertMessage: ApiClient.AlertMessage, buttonTitle: String, presenter: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertMessage.title, message: alertMessage.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            presenter.present(alert, animated: true)
        }
    }
}

extension UITextView {
    func hyperLink(originalText: String, hyperLink: String, urlString: String) {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSMakeRange(0, attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 10), range: fullRange)
        self.attributedText = attributedOriginalText
    }
}
