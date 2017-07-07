//
//  LNAlertProtocol.h
//  AlertViewManager
//
//  Created by Jacue on 2017/7/6.
//  Copyright © 2017年 Jacue. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LNAlertProtocol <NSObject>

// 弹窗的优先级
- (NSInteger)level;

// 弹窗顶替时隐藏弹窗
- (void)dismissWithCompletion:(void(^)(void))completionBlock;

@end
