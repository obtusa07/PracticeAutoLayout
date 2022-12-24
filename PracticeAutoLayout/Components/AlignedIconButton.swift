//
//  AlignedIconButton.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//

import UIKit

class AlignedIconButton: UIButton {
    
    // 아이콘 방향 설정
    enum IconAlignment {
        case leading
        case trailing
    }
    
    var iconAlignment: IconAlignment = .leading
    
    // 패딩 기본값
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
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
                     icon: UIImage? = nil,
                     padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20),
                     iconAlignment: IconAlignment = .leading
    ) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.tintColor = foregroundColor
        self.layer.cornerRadius = radius
        self.setImage(icon, for: .normal)
        self.padding = padding
        self.iconAlignment = iconAlignment
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        switch iconAlignment {
        case .leading:
            alignIconLeading()
        case .trailing:
            alignIconTrailing()
        }
        contentEdgeInsets = padding
    }
}

// MARK: - 아이콘 정렬 관련
extension AlignedIconButton {
    
    fileprivate func alignIconLeading() {
        contentHorizontalAlignment = .left
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        let imageWidth = imageView?.frame.width ?? 0
        let leftPadding = (availableWidth / 2) - (imageWidth / 2)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
        //전체적인 padding을 넣기 위해서는
        contentEdgeInsets = padding
    }
    
    fileprivate func alignIconTrailing() {
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        let imageWidth = imageView?.frame.width ?? 0
        let rightPadding = (availableWidth / 2) - (imageWidth / 2)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightPadding)
    }
}
