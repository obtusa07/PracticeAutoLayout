//
//  LoadingButton.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/26.
//

import UIKit

class LoadingButton: UIButton {
    
    // 로딩 상태
    enum LoadingState {
        case normal
        case loading
    }
    // 아이콘 방향 설정
    enum IconAlignment {
        case leading
        case trailing
    }
    
    /// 로딩 상태
    var loadingState: LoadingState = .normal {
        didSet {
            DispatchQueue.main.async {
                switch self.loadingState {
                case .normal: self.hideLoading()
                case .loading: self.showLoading()
                }
            }
        }
    }
    
    // 해당 인디케이터를 처음에는 nil로 선언하고 추후 상태에 따라 정의하여 사용한다.
    var indicator: UIActivityIndicatorView? = nil
    
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
                     iconAlignment: IconAlignment = .leading,
                     font: UIFont = UIFont.Sunflower(.medium, size: 20)
    ) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.tintColor = foregroundColor
        self.layer.cornerRadius = radius
        self.setImage(icon, for: .normal)
        self.padding = padding
        self.iconAlignment = iconAlignment
        self.titleLabel?.font = font
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
extension LoadingButton {
    
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

// MARK: - 인디케이터 관련
extension LoadingButton {
    /// 로딩 숨기기
    fileprivate func hideLoading() {
        // 로그인 버튼 비활성화 한거 다시 활성화
        self.isUserInteractionEnabled = true
        
        UIView.transition(with: self,
                          duration: 0.2,
                          options: .curveEaseIn,
                          animations: {
            // 여기 아래에서는 알파를 1로 해서 드러나게 함
            self.titleLabel?.alpha = 1
            self.imageView?.alpha = 1
            self.indicator?.alpha = 0
        })
    }
    /// 로딩 보여주기
    fileprivate func showLoading() {
        // 로그인 버튼 눌렸을때 비활성화 하는 예시
        self.isUserInteractionEnabled = false
        
        if indicator == nil {
            let myIndicator = UIActivityIndicatorView(style: .medium).then {
                $0.color = .white
                $0.startAnimating()
            }
            self.addSubview(myIndicator)
            myIndicator.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            self.indicator = myIndicator
        }
        self.titleLabel?.alpha = 0
        self.imageView?.alpha = 0
        UIView.transition(with: self,
                          duration: 0.2,
                          options: .curveEaseOut,
                          animations: {
            // 여기 아래에서는 알파를 1로 해서 드러나게 함
//            self.titleLabel?.alpha = 0
//            self.imageView?.alpha = 0
            self.indicator?.alpha = 1
        })
    }
}
