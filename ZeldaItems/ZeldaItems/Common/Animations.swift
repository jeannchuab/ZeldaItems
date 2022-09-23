//
//  Animations.swift
//  ZeldaItems
//
//  Created by Jeann Luiz Chuab on 16/09/22.
//

import UIKit

class Animations {
    static func animateButton(_ viewToAnimate: UIView, completion: @escaping (() -> ())) {
        UIView.animate(withDuration: 0.10, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }){ (_) in
            UIView.animate(withDuration: 0.10,  animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                completion()
            })
        }
    }
}
