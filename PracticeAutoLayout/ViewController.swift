//
//  ViewController.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    lazy var myScrollView: UIScrollView = UIScrollView().then {
        // 스크롤바 바운싱 설정
        $0.isUserInteractionEnabled = true
        // 바운스 방향 vertical로
        $0.alwaysBounceVertical = true
        $0.alwaysBounceHorizontal = false
        $0.addSubview(containerView)
    }
    
    lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .systemYellow
        $0.addSubview(butttonStackView)
    }
    lazy var butttonStackView: UIStackView = UIStackView().then {
        // 아이템들 간의 간격
        $0.spacing = 10
        $0.alignment = .fill // 아이템이 채워지는 정도
        $0.axis = .vertical // 방향
        $0.distribution = .fillEqually // 아이템들이 동일하게 분산되게
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        setupUI()
    }
    // UI 설정
    fileprivate func setupUI() {
        print(#fileID, #function, #line, "- ")
        self.view.addSubview(myScrollView)
        myScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        butttonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        containerView.snp.makeConstraints {
            $0.width.equalTo(myScrollView.frameLayoutGuide.snp.width)
            $0.edges.equalTo(myScrollView.contentLayoutGuide.snp.edges)
        }
        let icon = UIImage(systemName: "square.and.arrow.up.fill")
        let dummyButtons = Array(0...20).map { index in
            AlignedIconButton(title: "\(index) 버튼")
        }
//        let myButton = UIButton(configuration: .filled()).then {
//            $0.setTitle("123", for: .normal)
//        }
        dummyButtons.forEach {
            butttonStackView.addArrangedSubview($0)
        }
        //butttonStackView.addArrangedSubview(dummyButtons)
    }

}


#if DEBUG

import SwiftUI

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewController().getPreview()
        //.previewLayout(.sizeThatFits)
            //.frame(width: 200, height: 100)
         .ignoresSafeArea()
    }
}
#endif
