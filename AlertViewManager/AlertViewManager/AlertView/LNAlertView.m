//
//  LNAlertView.m
//  AlertViewManager
//
//  Created by Jacue on 2017/7/6.
//  Copyright © 2017年 Jacue. All rights reserved.
//

#import "LNAlertView.h"

@implementation LNAlertView

// 弹窗的优先级
- (NSInteger)level {
    return 6;
}

// 弹窗顶替时隐藏弹窗
- (void)dismissWithCompletion:(void(^)(void))completionBlock {
    [self dismissManually:NO];
    if (completionBlock) {
        completionBlock();
    }
}

// 手动隐藏弹窗
-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [self dismissManually:YES];
}

- (void)dismissManually:(BOOL)isManual {
    [super dismissWithClickedButtonIndex:self.cancelButtonIndex animated:NO];
    [[LNAlertManager sharedManager] dismissCurrentAlertViewManually:isManual];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
