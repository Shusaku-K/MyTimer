//
//  SettingView.swift
//  MyTimer
//
//  Created by 金城秀作 on 2021/02/14.
//  SettingViewの呼び出しはContentViewの92行目を確認。

import SwiftUI

struct SettingView: View {
    
    // 永続化する秒数設定（初期値は10
    @AppStorage("timer_value") var timerValue = 10
    

    
    var body: some View {
        //奥行き（背景の設定）
        ZStack {
            // 背景色表示
            Color("backgroundSetting")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            //垂直にレイアウト(テキストを縦並びに表示)
            VStack {
                
                Spacer()
                Text("\(timerValue)秒")
                    .font(.largeTitle)
                Spacer()
                
                 // Pickerを表示（秒数を変えたい場合はここを変更）
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
                
                Spacer()
                
            }
            
            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
