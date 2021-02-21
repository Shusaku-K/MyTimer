//
//  ContentView.swift
//  MyTimer
//
//  Created by 金城秀作 on 2021/02/14.
//
// 完成図
//　1.「スタート」「ストップ」ボタンで「開始」「停止」「再開」する
//　2.「秒数設定」を別の画面で開き設定できるようにする

//　ユーザー操作
//　1.「スタート」「ストップ」をボタンで操作する
//　2.「秒数」を設定する

import SwiftUI

struct ContentView: View {
    // タイマーの変数を作成
    @State var timerHandler : Timer?
    // カウント(経過時間)の変数を作成
    @State var count = 0
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value")  var timerValue = 10
    // アラート表示有無
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            // 奥行き（背景）レイアウト
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                
                // View(部品)間の間隔を30にする
                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    
                    // 水平にレイアウト(横方向にレイアウト)ボタンを2つ。
                    HStack {
                        //ボタン１（スタートボタン）
                        Button(action: {
                            // ボタンをタップしたときのアクション
                            // タイマーをカウントダウン開始する関数を呼び出す
                            startTimer()
                            
                        }) {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("startColor"))
　　　　　　　　　　　　　　　　　　　// Text"スタート"の背景を円形に切り抜く
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                        //ボタン2（ストップボタン）
                        Button(action: {
                            // ボタンをタップしたときのアクション
                            // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                // もしタイマーが、実行中だったら停止
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                            
                        }) {
                            //スタートボタンと同様
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                        
                    }
                    
                }
                // 画面が表示されるときに実行される
                .onAppear {
                    // カウント(経過時間)の変数を初期化
                    count = 0
                }
                
            }
            // ナビゲーションバーにボタンを追加
            // ナビゲーション遷移~テキストを表示
            //SettingViewの呼び出し。SettingViewの設定はSettingView.swift。
            .navigationBarItems(trailing: NavigationLink(destination: SettingView()) {
                Text("秒数設定")
            })
        }
        // 状態変数showAlertがtrueになったときに実行される
        // ダイアログを表示させる。iphonでよく出る通知表示。
        .alert(isPresented: $showAlert) {
            Alert(title: Text("終了"),
                  message: Text("タイマー終了時間です"),
                  dismissButton: .default(Text("OK")))
        }
        
    }
// 1秒毎に実行されてカウントダウンする
func countDownTimer() {
    // count(経過時間)に+1していく
    count += 1
    
    // 残り時間が0以下のとき、タイマーを止める
    if timerValue - count <= 0 {
        // タイマー停止
        timerHandler?.invalidate()
        // アラート表示する
        showAlert = true
    }
    
}
// タイマーをカウントダウン開始する関数
func startTimer() {
    
    // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
    if let unwrapedTimerHandler = timerHandler {
        // もしタイマーが、実行中だったらスタートしない
        if unwrapedTimerHandler.isValid == true {
            return
        }
    }
    // 残り時間が0以下のとき、count(経過時間)を0に初期化する
    if timerValue - count <= 0 {
        count = 0
    }
     // タイマーをスタート
    timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
        _ in
        // タイマー実行時に呼び出される
        // 1秒毎に実行されてカウントダウンする関数を実行する
        countDownTimer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

}
