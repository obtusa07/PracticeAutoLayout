//
//  UIView+Extension.swift
//  PracticeAutoLayout
//
//  Created by Taehwan Kim on 2022/12/24.
//

import Foundation

#if DEBUG
import SwiftUI

extension UIView {
    private struct ViewRepresentable: UIViewRepresentable {
        let uiView: UIView
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
        
        func makeUIView(context: Context) -> some UIView {
            return uiView
        }
    }
    func getPreview() -> some View {
        ViewRepresentable(uiView: self)
    }
}
#endif
