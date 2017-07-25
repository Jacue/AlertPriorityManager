# AlertPriorityManager
管理弹层的优先级


##1、目的

避免弹层的时候，造成弹窗的重叠，实现多个弹层按照优先级高低依次进行展示。


##2、策略

需要设置优先级的弹层对象（任意类型，继承自NSObject即可），需遵循`LNAlertProtocol`协议,实现两个协议方法
```
/**
    弹层的优先级
*/
- (NSInteger)level;
```

```
/**
    发生弹层顶替时用户执行隐藏弹层的操作
*/
- (void)dismissWithCompletion:(void(^)(void))completionBlock;
```

使用统一的弹层管理类`LNAlertManager`控制弹层的展示和隐藏，通过持有弹层对象数组`lowPriorityAlertViewArray`和弹层隐藏操作数组`lowPriorityAlertBlockArray`来保存所有弹层信息，保证它们都能得到展示，但每次只展示一个弹层。




