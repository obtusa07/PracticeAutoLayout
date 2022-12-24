//
//  UIViewController+Extension.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//

import UIKit



#if DEBUG
import SwiftUI

extension UIViewController {
    private struct VCRepresentable: UIViewControllerRepresentable {
        let viewController: UIViewController
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }
    func getPreview() -> some View {
        VCRepresentable(viewController: self)
    }
}
#endif

