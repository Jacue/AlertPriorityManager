//
//  View4.m
//  AlertViewManager
//
//  Created by Jacue on 2017/7/7.
//  Copyright © 2017年 Jacue. All rights reserved.
//

#import "View4.h"

@implementation View4

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = [NSString stringWithFormat:@"%ld",[self level]];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor orangeColor];
        [self addSubview:label];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (NSInteger)level {
    return 4;
}

-(void)dismissWithCompletion:(void (^)(void))completionBlock {
    [self dismissManually:NO];
    if (completionBlock) {
        completionBlock();
    }
}

- (void)dismiss {
    [self dismissManually:YES];
}

- (void)dismissManually:(BOOL)isManual {
    [self removeFromSuperview];
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
