//
//  CYMemoryCache.m
//  LRUCacheDemo
//
//  Created by chenyan on 2020/5/12.
//  Copyright © 2020 modernmedia. All rights reserved.
//

#import "CYMemoryCache.h"
#import "CYChainTable.h"


@interface CYMemoryCache () {
    
    CYChainTable *_chainTable;
}

@end

@implementation CYMemoryCache

#pragma mark - init

- (instancetype)init {
    
    NSInteger defaultCapacity = 100;
    return [[CYMemoryCache alloc] initWithCapacity:defaultCapacity];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    
    if (self = [super init]) {
        
        _capacity = capacity;
        _chainTable = [[CYChainTable alloc] init];
    }
    return self;
}

#pragma mark - getter

- (NSUInteger)cost {
    
    @synchronized (self) {
        
        return _chainTable.totalCost;
    }
}

#pragma mark - pravite

/** 清除缓存至cost为capacity */
- (void)clearToCapacity:(NSInteger)capacity {
    
    @synchronized (self) {
        
        if (capacity == 0) {
            
            [self removeAllItems];
        } else if (_chainTable->_totalCost <= capacity) {
            
            return;
        }
    
        while (1) {
                
            if (_chainTable->_totalCost > capacity) {
                
                [_chainTable removeTailNode];
            } else {
                
                break;
            }
        }
    }
}

#pragma mark - public

- (void)setItem:(id)item forKey:(NSString *)key {
    
    [self setItem:item forKey:key withCost:0];
}
 
- (void)setItem:(id)item forKey:(id)key withCost:(NSUInteger)cost {
    
    @synchronized (self) {
    
        if (!key) return;
        
        if (!item) {
            
            //如果没有item即为移除
            [self removeItemForKey:key];
        }
        //如果缓存已有
        CYChainTableNode *node = CFDictionaryGetValue(_chainTable->_dic, (__bridge const void *)(key));
        
        if (node) {
            
            //更新该节点的消耗值
            _chainTable->_totalCost -= node->_cost;
            _chainTable->_totalCost += cost;
            node->_cost = cost;
            node->_value = item;
            [_chainTable bringNodeToHead:node];
        } else {
            
            node = [[CYChainTableNode alloc] init];
            node->_cost = cost;
            node->_key = key;
            node->_value = item;
            [_chainTable insertNodeAtHead:node];
        }
        
        if (_chainTable->_totalCost > _capacity) {
            
            //缓存超限判断
            [self clearToCapacity:_capacity];
        }
    }
}

- (id)itemForKey:(NSString *)key {
    
    @synchronized (self) {

        if (!key.length) return nil;
         
        CYChainTableNode *node = CFDictionaryGetValue(_chainTable->_dic, (__bridge const void *)(key));
        if (node) {
            
            //更新访问时序
            [_chainTable bringNodeToHead:node];
        }
        return node? node->_value : nil;
    }
}

- (void)removeItemForKey:(NSString *)key {
    
    @synchronized (self) {
    
        if (!key.length) return;
     
        CYChainTableNode *node = CFDictionaryGetValue(_chainTable->_dic, (__bridge const void *)(key));
        if (node) {
            
            [_chainTable removeNode:node];
        }
    }
}

- (void)removeAllItems {
    
    @synchronized (self) {
       
        [_chainTable removeAllNodes];
    }
}

@end
