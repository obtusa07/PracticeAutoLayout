//
//  CustomView.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//

import UIKit
import SnapKit
import Then

class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    fileprivate func setupUI() {
        self.backgroundColor = .systemYellow
        let icon = UIImage(systemName: "square.and.arrow.up.fill")
        //        let dummyButtons = Array(0...20).map { index in
        //            AlignedIconButton(title: "\(index) 버튼")
        //        }
        let button = AlignedIconButton(title: "qqjqj", icon: icon)
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
    }
}


#if DEBUG

import SwiftUI

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
            .getPreview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
