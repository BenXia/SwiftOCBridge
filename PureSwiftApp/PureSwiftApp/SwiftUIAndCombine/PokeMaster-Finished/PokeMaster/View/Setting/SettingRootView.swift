//
//  SettingRootView.swift
//  PokeMaster
//
//  Created by Ben on 2023/08/11.
//  Copyright © 2023 Ben. All rights reserved.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView()
                .navigationBarTitle("设置")
        }
    }
}

#if DEBUG
struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView().environmentObject(Store.sample)
    }
}
#endif
