//
//  ViewController.m
//  Post
//
//  Created by 苏苏咯 on 2017/4/9.
//  Copyright © 2017年 苏苏咯. All rights reserved.
//

#import "ViewController.h"
#import "Request.h"
#import "CodeData.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Request GetCodebackResult:^(id value, OXHttpError *error) {
        CodeData * response=value;
       // NSLog(@"%@" , error.errorDesc);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
