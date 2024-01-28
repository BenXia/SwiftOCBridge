//
//  LoadingView.swift
//  PokeMaster
//
//  Created by Ben on 2023/08/26.
//  Copyright © 2023 Ben. All rights reserved.
//

import SwiftUI

struct LoadingView: View, Animatable {

    @State var imageIndex: Int = 0
    @State var disabled = false

    var body: some View {
        VStack {
            Image("loading-\(imageIndex % 4)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.imageIndex = (self.imageIndex + 1) % 4
                if self.disabled {
                    timer.invalidate()
                }
            }
        }.onDisappear {
            self.disabled = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
