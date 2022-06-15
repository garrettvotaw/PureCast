//
//  PlayerView.swift
//  PureCast
//
//  Created by Garrett Votaw on 12/2/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    
    @ObservedObject var audioPlayer: AudioPlayer
    @Binding var audioProgress: Double
    @Binding var isVisible: Bool
    
    var songIsLoaded: Bool {
        audioPlayer.url != nil
    }
    
    var body: some View {
        if isVisible {
            GeometryReader { geometry in
                    Rectangle()
                        .foregroundColor(Color("WhiteBlack"))
                        .frame(maxHeight: 100)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            VStack {
                                ProgressionView(timeObserver: audioPlayer)
                                    .ignoresSafeArea()
                                PlayerControls(audioPlayer: audioPlayer)
                                Text("\(audioPlayer.currentItem)")
                                    .font(.callout)
                                    .minimumScaleFactor(1.0)
                                    .padding(.top)
                                    .padding(.horizontal)
                                Spacer()
                            }
                        )
                        .edgesIgnoringSafeArea(.bottom)
                
            }
            .frame(maxHeight: 120)
            .edgesIgnoringSafeArea(.bottom)
        } else {
            EmptyView()
        }
    }
  
}

struct PlayerControls: View {
    @ObservedObject var audioPlayer: AudioPlayer
    
    var body: some View {
        HStack {
            Button {
                audioPlayer.seekFarBack()
            } label: {
                Image(systemName: "gobackward")
                    .resizable()
                    .frame(width: 20, height: 23, alignment: .center)
                    .foregroundColor(Color("BlackWhite"))
            }
            .padding(.trailing)
            Button {
                audioPlayer.seekBack()
            } label: {
                Image(systemName: "gobackward.15")
                    .resizable()
                    .frame(width: 20, height: 23, alignment: .center)
                    .foregroundColor(Color("BlackWhite"))
            }
            .padding(.trailing)

            PlayButton(audioPlayer: audioPlayer)
                
            
            Button {
                audioPlayer.seekForward()
            } label: {
                Image(systemName: "goforward.30")
                    .resizable()
                    .frame(width: 20, height: 23, alignment: .center)
                    .foregroundColor(Color("BlackWhite"))
            }
            .padding(.leading)
            
            Button {
                audioPlayer.seekFarForward()
            } label: {
                Image(systemName: "goforward")
                    .resizable()
                    .frame(width: 20, height: 23, alignment: .center)
                    .foregroundColor(Color("BlackWhite"))
            }
            .padding(.leading)
        }
    }
}

struct ProgressionView: View {
    let timeObserver: AudioPlayer
    @State private var currentTime: TimeInterval = 0
    @State private var currentProgress: TimeInterval = 0
//    let gradient = Gradient(colors: [Color("Accent"), Color("Color")])
      var body: some View {
        VStack {
            ProgressView(value: currentProgress)
                .onReceive(timeObserver.publisher) { time in
                    self.currentProgress = time/timeObserver.player.currentItem!.duration.seconds
                    self.currentTime = time
                }
                .accentColor(Color("BlackWhite"))
                .animation(.easeInOut(duration: 1))
            HStack {
                Text("\(Utility.formatSecondsToHMS(currentTime))")
                    .padding(.leading)
                Spacer()
                if let time = timeObserver.player.currentItem?.duration {
                    Text("\(Utility.formatSecondsToHMS(time.seconds))")
                        .padding(.trailing)
                } else {
                    EmptyView()
                }
            }
        }
      }

}


struct PlayButton: View {
    @ObservedObject var audioPlayer: AudioPlayer
    
    var body: some View {
        Button(action: {
            audioPlayer.playPause()
        }, label: {
            Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 25, height: 27, alignment: .center)
                .foregroundColor(Color("BlackWhite"))
                .padding(.horizontal)
        })
    }
}


