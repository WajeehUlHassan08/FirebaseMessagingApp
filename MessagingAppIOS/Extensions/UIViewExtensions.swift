//
//  UIViewExtensions.swift
//  MessagingAppIOS
//
//  Created by Wajeeh Ul Hassan on 05/08/2022.
//

import UIKit

extension UIView {
    
    static func createBufferView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        view.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(1), for: .horizontal)

        return view
    }
    
}
