//
//  AlignedIconButton.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//

import UIKit

class AlignedIconButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    convenience init(title: String = "타이틀 없음",
                     bgColor: UIColor = .systemBlue,
                     foregroundColor: UIColor = .white,
                     radius: CGFloat = 8,
                     icon: UIImage? = nil
    ) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.tintColor = foregroundColor
        self.layer.cornerRadius = radius
        self.setImage(icon, for: .normal)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
