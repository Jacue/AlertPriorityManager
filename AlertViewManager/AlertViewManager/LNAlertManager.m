//
//  LNAlertManager.m
//  AlertViewManager
//
//  Created by Jacue on 2017/7/6.
//  Copyright © 2017年 Jacue. All rights reserved.
//

#import "LNAlertManager.h"

typedef void(^AlertBlock)(void);

@interface LNAlertManager ()

// 当前展示的弹层对象（如果用户手动关闭弹层，需还原为初始值），当被优先级高的顶替时，需更新为最新的弹层对象
@property (nonatomic,strong) UIView<LNAlertProtocol> *currentAlertView;
@property (nonatomic,copy) AlertBlock currentAlertBlock;
// 延迟展示的（优先级低的）弹层对象数组（场景1:优先级低->优先级高；场景2:优先级高->优先级低）
@property (nonatomic,strong) NSMutableArray<UIView<LNAlertProtocol> *> *lowPriorityAlertViewArray;
// 延迟展示的弹层操作
@property (nonatomic,strong) NSMutableArray<AlertBlock> *lowPriorityAlertBlockArray;


@end

@implementation LNAlertManager

+ (instancetype)sharedManager {
    static LNAlertManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.lowPriorityAlertViewArray = [NSMutableArray array];
        instance.lowPriorityAlertBlockArray = [NSMutableArray array];
    });
    return instance;
}

/**
 延迟展示的（优先级低的）弹层对象数组中优先级最高

 @return 索引值
 */
- (NSInteger)indexOfHightestPriorityAlertView {
    NSInteger index = 0;
    NSInteger level = 0;
    for (UIView<LNAlertProtocol> *alertView in self.lowPriorityAlertViewArray) {
        if ([alertView level] > level) {
            level = [alertView level];
            index = [self.lowPriorityAlertViewArray indexOfObject:alertView];
        }
    }
    return index;
}

/**
 用户手动隐藏弹窗需把当前保存的优先级、弹窗还原。
 */
- (void)dismissCurrentAlertViewManually:(BOOL)isManual{
    
    // 手动隐藏，将当前优先级、弹窗对象还原。
    if (isManual) {
        _currentAlertView = nil;
        _currentAlertBlock = nil;
        
        // 手动隐藏当前弹层后，展示被顶替的弹层数组中优先级最高的那一个
        if (self.lowPriorityAlertViewArray.count > 0) {
            NSInteger index = [self indexOfHightestPriorityAlertView];
            UIView<LNAlertProtocol> *alertView = self.lowPriorityAlertViewArray[index];
            AlertBlock block = self.lowPriorityAlertBlockArray[index];
            
            [self show:alertView showBlock:block];
            
            // 一旦展示，就从被顶替的弹层数组中移除
            [self.lowPriorityAlertViewArray removeObjectAtIndex:index];
            [self.lowPriorityAlertBlockArray removeObjectAtIndex:index];
        }
    }
}


/**
 展示弹层

 @param alertView 弹层
 @param alertBlock 弹层的展示操作
 */
- (void)show:(UIView<LNAlertProtocol> *)alertView showBlock:(void(^)(void))alertBlock{
    
    // 1:判断当前是否正在展示alertView之外的弹层，如果没有，展示alertView，并保存优先级和弹层对象
    if (!_currentAlertView) {
        
        _currentAlertView = alertView;
        _currentAlertBlock = alertBlock;
        
        alertBlock();
        return;
    }
    
    // 2:如果有，则判断优先级
    NSInteger newLevel = [alertView level];
    if (newLevel > [_currentAlertView level]) {
        
        __weak typeof(self)weakSelf = self;
        
        [_currentAlertView dismissWithCompletion:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            
            // 将被顶替的弹层放到延迟展示的数组中
            [strongSelf.lowPriorityAlertViewArray addObject:strongSelf.currentAlertView];
            [strongSelf.lowPriorityAlertBlockArray addObject:strongSelf.currentAlertBlock];

            // 更新当前状态
            strongSelf.currentAlertView = alertView;
            strongSelf.currentAlertBlock = alertBlock;
            
            alertBlock();
            
            return;
        }];
    }else{
        // 将被顶替的弹层放到延迟展示的数组中
        [_lowPriorityAlertViewArray addObject:alertView];
        [_lowPriorityAlertBlockArray addObject:alertBlock];
    }
}

@end
