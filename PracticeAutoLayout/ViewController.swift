//
//  ViewController.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//

import UIKit
import SnapKit
import Then
import Combine
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    // combine
    @Published var loadingState: LoadingButton.LoadingState = .normal
    var subscriptions = Set<AnyCancellable>()
    
    // rx
    let loadingStateRx = BehaviorRelay<LoadingButton.LoadingState>(value: .normal)
    var disposeBag = DisposeBag()
    
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
        let dummyButtons: [LoadingButton] = Array(0...20).map { index in
            LoadingButton(title: "\(index) 버튼", icon: icon, iconAlignment: .leading)
        }
        dummyButtons.forEach {
            butttonStackView.addArrangedSubview($0)
            $0.addTarget(self, action: #selector(onButtonClicked(_:)), for: .touchUpInside)
            // MARK: - Combine
            // published 된 요소를 사용하고자 하면 앞에 $사인을 붙인다.
            // on은 붙이고자 하는 객체. 이 경우에는 dummyButtons들이다.
            // to는 on에서 붙은 객체의 속성들이다.
            // combine에서는 메모리 관리를 해줘야 한다.
            // 콤바인 퍼플리셔 데이터 상태 <-> 버튼의 loadingState
//            self.$loadingState
//                .assign(to: \.loadingState, on: $0)
//                .store(in: &subscriptions)
            
            // MARK: - Rx
            // Rx 옵저버블 데이터 상태 <-> 버튼의 loadingState
            self.loadingStateRx
                .bind(to: $0.rx.loadingState)
                .disposed(by: disposeBag)
            
        }
        let loadingStateLabel = UILabel().then {
            $0.text = "로딩 상태 레이블"
            $0.font = UIFont.systemFont(ofSize: 30)
            $0.backgroundColor = .white
        }
        self.view.addSubview(loadingStateLabel)
        loadingStateLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        // combine
        self.$loadingState
            .map { $0 == .loading ? "로딩중" : "일반" }
            .assign(to: \.text, on: loadingStateLabel)
            .store(in: &subscriptions)
        
        // Rx
        self.loadingStateRx
            .map { $0 == .loading ? "로딩중" : "일반" }
            .bind(to: loadingStateLabel.rx.text)
            .disposed(by: disposeBag)
        
    }

}

// MARK: - 액션관련
extension ViewController {
    
    ///  버튼 클릭시 (해당 화면은 옵션 커맨드 쉬프트로 만들수 있다.)
    /// - Parameter sender: 클릭한 버튼
    @objc fileprivate func onButtonClicked(_ sender: LoadingButton) {
        
        // 만약 이 버튼이 로그인 버튼이라면 한번 눌리면 못 누르게 해야함
        // 아래 코드로 눌렸다는 것이 감지되면 return으로 함수를 끝내서 다시 눌리는걸 예방할 수 있음. 혹은 로딩 버튼에서 isUserInteractionEnabled를 비활성화 하는 방법으로도 막아놨음
        // MARK: - combine
//        if self.loadingState == .loading {
//            return
//        }
//        self.loadingState = .loading
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            self.loadingState = .normal
//        })
        // MARK: - Rx
        
        if self.loadingStateRx.value == .loading {
            return
        }
        
        self.loadingStateRx.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loadingStateRx.accept(.normal)
        })
        
        // combine의 publisher 데이터 상태를 변경
//        if self.loadingState == .normal {
//            self.loadingState = .loading
//        } else {
//            self.loadingState = .normal
//        }
//        sender.loadingState = sender.loadingState == .loading ? .normal : .loading
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
