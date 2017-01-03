//
//  _moSpeaker.m
//  MoSpeaker
//
//  Created by Moling on 17/1/3.
//  Copyright © 2017年 Moling. All rights reserved.
//

#import "_moSpeaker.h"
#import <AVFoundation/AVFoundation.h>

@implementation _moSpeaker{
    
    //声音字典
    NSDictionary * _voiceDictionary;

    //语音合成播放器
    AVPlayer * _voicePlayer;

    //记录语音条目
    NSMutableArray * _voiceArr;
    
}

- (instancetype)init{
    
    if (self =  [super init]) {
        
        //实例化
        _voicePlayer = [[AVPlayer alloc]init];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"voice.json" withExtension:nil subdirectory:@"voice.bundle"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 反序列化
        _voiceDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
        
        //注册通知
        //监听 item 的通知 (防止在播放条目过多时 播放语序不正确以及播放条目不完整)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playItemDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        // application background
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
        
        // 优化多音频播放
        [[AVAudioSession sharedInstance] setActive:YES error:NULL];
        
    }
    return self;
}

- (void)playtheVoiceWithNSString:(NSString *)voiceStr{
    
    NSArray * array = [voiceStr componentsSeparatedByString:@" "];
    
    _voiceArr = [NSMutableArray arrayWithArray:array];
    
    [self playFirstVoice];
}

- (void)playFirstVoice{
    
    if (_voiceArr.count == 0) {
        return;
    }
    
    NSString * str = _voiceArr.firstObject;
    [_voiceArr removeObjectAtIndex:0];
    NSString * mp3 = _voiceDictionary[str];
    
    NSURL * url = [[NSBundle mainBundle]URLForResource:mp3 withExtension:nil subdirectory:@"voice.bundle"];
    
    if (url == nil) {
        
        [self playFirstVoice];
        NSLog(@"[%@] 对应的 mp3 没有找到", str);
        return;
    }
    
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:url];
    [_voicePlayer replaceCurrentItemWithPlayerItem:item];
    [_voicePlayer play];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)playItemDidEnd:(NSNotification *)notification {
    
    NSLog(@"播放已经完成");
    
    //上一条目一旦播放完整 直接开始播放下一条目
    [self playFirstVoice];
}


@end
