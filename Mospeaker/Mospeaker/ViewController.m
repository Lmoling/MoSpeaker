//
//  ViewController.m
//  Mospeaker
//
//  Created by Moling on 17/1/3.
//  Copyright © 2017年 Moling. All rights reserved.
//

#import "ViewController.h"
#import "_moSpeaker.h"
@interface ViewController ()

@end

@implementation ViewController{
    
    _moSpeaker * _mospeaker;
    
    NSString * _str;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mospeaker = [[_moSpeaker alloc]init];
    
    UIButton * btn1 = [[UIButton alloc]init];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"开始播报" forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor redColor]];
    [btn1 sizeToFit];
    btn1.center = self.view.center;
    [btn1 addTarget:self action:@selector(thrSpeakerPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

}
- (void)thrSpeakerPlay{
    
    _str = @"店立方 为您收款 0 元 整";
    
    [_mospeaker playtheVoiceWithNSString:_str];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
