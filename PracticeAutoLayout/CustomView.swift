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
