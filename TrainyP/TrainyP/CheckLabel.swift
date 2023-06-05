//
//  CheckLabel.swift
//  TrainyP
//
//  Created by Linh Chu on 23.05.23.
//

import Foundation

struct CheckLabel{
    func checkLabel(label: String) -> Bool {
      let newText = label
      // Don't accept characters that can cause problems in the file system.
      let sanitized = newText.components(separatedBy: .init(charactersIn: #"./\?%*|"<>"#)).joined()

      return (newText.count > 0) && (newText == sanitized)
    }
}
