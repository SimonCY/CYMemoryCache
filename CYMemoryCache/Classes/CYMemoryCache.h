//
//  CYMemoryCache.h
//  LRUCacheDemo
//
//  Created by chenyan on 2020/5/12.
//  Copyright © 2020 modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYMemoryCache : NSObject

//容量
@property (nonatomic, assign, readonly) NSInteger capacity;

//当前消耗值
@property (nonatomic, assign, readonly) NSUInteger cost;

- (instancetype)initWithCapacity:(NSUInteger)capacity;

/** cost of item is 0 */
- (void)setItem:(nullable id)item forKey:(id)key;

- (void)setItem:(nullable id)item forKey:(id)key withCost:(NSUInteger)cost;

- (id)itemForKey:(NSString *)key;

- (void)removeItemForKey:(NSString *)key;

- (void)removeAllItems;

@end

NS_ASSUME_NONNULL_END
