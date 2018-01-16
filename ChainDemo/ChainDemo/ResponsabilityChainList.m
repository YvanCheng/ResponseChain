//
//  ResponsabilityChainList.m
//  ChainDemo
//
//  Created by chengyulong on 2018/1/4.
//  Copyright © 2018年 chengyulong. All rights reserved.
//

#import "ResponsabilityChainList.h"

@interface NSString (Chain)

/**
 *  各个维度的枚举num的数组，生成唯一的字符串
 *
 *  @param enumNums 枚举num的数组
 */
+ (nonnull NSString *)enumNumString:(nonnull NSArray<NSNumber *> *)enumNums;

@end

@implementation NSString (Chain)

+ (nonnull NSString *)enumNumString:(nonnull NSArray<NSNumber *> *)enumNums{
    if (isNull(enumNums)) {
        return @"";
    }
    NSString *enumNumString = @"";
    for (NSNumber *enumNum in enumNums) {
        enumNumString = [enumNumString stringByAppendingString:enumNum.stringValue];
        enumNumString = [enumNumString stringByAppendingString:@","];
    }
    return enumNumString;
}

@end

@interface ResponsabilityChain()

@property (nonatomic, weak)   id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSMutableArray<NSString *> *dimensions;

@end

@implementation ResponsabilityChain

+ (nonnull instancetype)instanceChain:(nonnull id)target selector:(nonnull SEL)selector{
    return [[ResponsabilityChain alloc] initWithTarget:target selector:selector];
}

- (instancetype)initWithTarget:(id)target
                      selector:(SEL)selector {
    self = [super init];
    if (self) {
        self.target = target;
        self.selector = selector;
        self.dimensions = [NSMutableArray array];
    }
    return self;
}

- (void)addEnumStringArray:(nonnull NSArray<NSArray<NSNumber *> *> *)enumNums{
    
    for (NSArray *enumNumbers in enumNums) {
        [self.dimensions addObject:[NSString enumNumString:enumNumbers]];
    }
}

@end


@interface ResponsabilityChainList ()

@property (nonatomic, strong) NSArray<ResponsabilityChain *> *chainList;
@property (nonatomic, weak) id defaultTarget;
@property (nonatomic, assign) SEL defaultSelector;

@end

@implementation ResponsabilityChainList

+ (nonnull instancetype)instanceResponsabilityChain:(nonnull NSArray<ResponsabilityChain *> *)responsabilityChain
                                      defaultTarget:(nonnull id)defaultTarget
                                    defaultSelector:(nonnull SEL)defaultSelector{
    
    return [[ResponsabilityChainList alloc] initWithChainList:responsabilityChain
                                                defaultTarget:defaultTarget
                                              defaultSelector:defaultSelector];
    
}

- (instancetype)initWithChainList:(NSArray<ResponsabilityChain *> *)chainList
                    defaultTarget:(id)defaultTarget
                  defaultSelector:(SEL)defaultSelector{
    self = [super init];
    if (self) {
        self.chainList = chainList;
        self.defaultSelector = defaultSelector;
        self.defaultTarget = defaultTarget;
    }
    return self;
}

- (nullable id)implementationMethodByConditionArray:(nonnull NSArray<NSNumber *> *)condition{
    if (condition.count <= 0) {
        NSAssert(condition, @"Condition is null");
    }
    NSString *conditionEnumStr = [NSString enumNumString:condition];
    for (ResponsabilityChain *chain in self.chainList) {
        for (NSString *enumeration in chain.dimensions) {
            if ([enumeration isEqualToString:conditionEnumStr]) {
                return [self p_performTargetSelector:chain];
            }
        }
    }
    if (self.defaultTarget && [self.defaultTarget respondsToSelector:self.defaultSelector]) {
        return [self.defaultTarget performSelector:self.defaultSelector];
    }
    return nil;
}

#pragma mark - Private
- (id)p_performTargetSelector:(ResponsabilityChain *)chain{
    if (chain.target && [chain.target respondsToSelector:chain.selector]) {
        [chain.target performSelector:chain.selector];
    }
    return nil;
}

@end
