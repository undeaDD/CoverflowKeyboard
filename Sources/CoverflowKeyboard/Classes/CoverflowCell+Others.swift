//
//  CoverflowCellProtocol.swift
//  CoverflowKeyboard
//
//  Created by Dominic Drees on 06.07.20.
//

import UIKit

public struct CellData {
    public let cellType: CellType
    public let title: String?
    public let image: UIImage?
    public let subtitle: String?
    
    public init(cellType: CellType, title: String?, image: UIImage?, subtitle: String?) {
        self.cellType = cellType
        self.title = title
        self.image = image
        self.subtitle = subtitle
    }
}

@available(iOS 11.0, *)
internal protocol CoverflowCellProtocol {
    func setUp(with data: CellData)
}

public enum CellType: String {
    case imageCell = "imageCell"
    case emojiCell = "emojiCell"
    case customCell = "customCell"
}

@available(iOS 11.0, *)
public protocol CoverflowDelegate {
    func didSelect(with keyboard: CoverflowKeyboard, cellAt indexPath: IndexPath)
}

@available(iOS 11.0, *)
extension UIButton {
    public func add(keyboard: CoverflowKeyboard) {
        let hidden = UITextField(frame: .zero)
        hidden.inputView = inputView
        inputView?.applyAutoLayout()
        addSubview(hidden)
        addTarget(self, action: #selector(presentKeyboard), for: .touchUpInside)
    }
    
    @objc
    func presentKeyboard() {
        subviews.first { ($0 as? UITextField != nil) }?.becomeFirstResponder()
    }
}

@available(iOS 11.0, *)
extension UITextField {
    public func add(keyboard: CoverflowKeyboard) {
        inputView = keyboard.inputView
        inputView?.applyAutoLayout()
    }
}

@available(iOS 11.0, *)
extension UIView {
    public func present(keyboard: CoverflowKeyboard) {
        let hidden = UITextField(frame: .zero)
        hidden.inputView = keyboard.inputView
        inputView?.applyAutoLayout()
        addSubview(hidden)
        hidden.becomeFirstResponder()
    }
    
    func applyAutoLayout(){
        if let parent = inputView?.superview{
            inputView?.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            inputView?.trailingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            inputView?.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            inputView?.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
    }
}
