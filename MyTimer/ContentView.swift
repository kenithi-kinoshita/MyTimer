//
//  ContentView.swift
//  MyTimer
//
//  Created by 木下健一 on 2021/10/21.
//

import SwiftUI

struct ContentView: View {
    
    //タイマーの変数
    @State var timerHandler : Timer?
    //カウントの変数
    @State var count = 0
    //永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10
    // アラート表示
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundTimer")
                    // リサイズする
                    .resizable()
                    // セーフエリアを超えて画面全体に配置
                    .edgesIgnoringSafeArea(.all)
                    // アスペクト比を維持して短辺基準に収まるようにする
                    .aspectRatio(contentMode: .fill)
                // 垂直にレイアウト
                // View間の間隔を30にする
                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    HStack {
                        // スタートボタン
                        Button(action: {
                            // ボタンをタップした時のアクション
                            // タイマーをカウントダウン開始する関数を呼び出す
                            startTimer()
                        }) {
                            Text("スタート")
                                // 文字サイズを指定
                                .font(.title)
                                // 文字色を白に指定
                                .foregroundColor(Color.white)
                                // 幅高さを140に指定
                                .frame(width: 140, height: 140)
                                // 背景を設定
                                .background(Color("startColor"))
                                // 円形にくりぬく
                                .clipShape(Circle())
                        }
                        // ストップボタン
                        Button(action: {
                            // ボタンをタップした時のアクション
                            // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                // もしタイマーが、実行中だったら停止
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        }) {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                        }
                    }
                }
            }
            // 画面が表示されるときに実行される
            .onAppear {
                // カウントの変数を初期化
                count = 0
            }
            // ナビゲーションにボタンを追加
            .navigationBarItems(trailing:
                // ナビゲーション遷移
                NavigationLink(destination: SettingView()) {
                    Text("秒数設定")
                }) // .navigationBarItems end
            // 状態変数showAlertがtrueになったときに実行される
            .alert(isPresented: $showAlert) {
                // アラートを表示するためのレイアウト
                // アラートを表示
                Alert(title: Text("終了"),
                      message: Text("タイマー終了時間です"),
                      dismissButton: .default(Text("OK")))
            } // .alert end
        } //NavigationView end
    }
    
    //1秒毎に実行されてカウントダウンする
    func countDownTimer() {
        // countに+1していく
        count += 1
        
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            //タイマー停止
            timerHandler?.invalidate()
            
            //アラート表示する
            showAlert = true
        }
    } //countDownTimer end
    
    // タイマーカウントダウンを開始する関数
    func startTimer() {
        //timerHandlerをアンラップしてunwrapedTimerHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            // タイマーが実行中だったらスタートしない
            if unwrapedTimerHandler.isValid == true {
                // 何もしない
                return
            }
        }
        
        // 残り時間が0以下のとき、countを0に初期化する
        if timerValue - count <= 0 {
            // countを0に初期化する
            count = 0
        }
        
        //タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // タイマー実行時に呼び出せる
            // 1秒毎に実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
    } // startTimer end
} // ContentView end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
