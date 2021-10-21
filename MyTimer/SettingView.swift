//
//  SettingView.swift
//  MyTimer
//
//  Created by 木下健一 on 2021/10/21.
//

import SwiftUI

struct SettingView: View {
    // 秒数設定
    @State var timerValue = 10
    
    var body: some View {
        ZStack {
            Color("backgroundSetting")
                // セーフエリアを超えて画面全体に配置
                .edgesIgnoringSafeArea(.all)
            
            //垂直にレイアウト
            VStack {
                Spacer()
                
                // 秒数の表示
                Text("\(timerValue)秒")
                    .font(.largeTitle)
                
                Spacer()
                
                Picker(selection: $timerValue, label: Text("選択")) {
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
