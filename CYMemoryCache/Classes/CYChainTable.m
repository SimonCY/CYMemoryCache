//
//  CYChainTable.m
//  LRUCacheDemo
//
//  Created by chenyan on 2020/5/12.
//  Copyright © 2020 modernmedia. All rights reserved.
//

#import "CYChainTable.h"

@implementation CYChainTableNode

@end

@interface CYChainTable ()

@end

@implementation CYChainTable

#pragma mark - init

- (instancetype)init {
    
    if (self = [super init]) {
     
         _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        _totalCost = 0;
    }
    return self;
}

#pragma mark - public
 
- (void)insertNodeAtHead:(CYChainTableNode *)node {
    
    CFDictionarySetValue(_dic, (__bridge const void *)(node->_key), (__bridge const void *)(node));
    _totalCost += node->_cost;
    
    if (_head) {
        
        node->_nextNode = _head;
        _head->_preNode = node;
        _head = node;
    } else {
        
        _head = node;
        _tail = node;
    }
}
 
- (void)bringNodeToHead:(CYChainTableNode *)node {
    
    if (_head == node) return;
    
    if (_tail == node) {
        
        //如果是尾结点
        _tail = node->_preNode;
        _tail->_nextNode = nil;
    } else {
        
        //如果是中间节点，拆除并连接两端
        node->_nextNode->_preNode = node->_preNode;
        node->_preNode->_nextNode = node->_nextNode;
    }
    
    //设置为新的头结点
    node->_nextNode = _head;
    node->_preNode = nil;
    _head->_preNode = node;
    _head = node;
}
 
- (void)removeNode:(CYChainTableNode *)node {
    
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(node->_key));
    _totalCost -= node->_cost;
    
    if (node->_nextNode) {
        
        node->_nextNode->_preNode = node->_preNode;
    }
    if (node->_preNode) {
        
        node->_preNode->_nextNode = node->_nextNode;
    }
    if (_head == node) {
        
        _head = node->_nextNode;
    }
    if (_tail == node) {
        
        _tail = node->_preNode;
    }
}
 
- (void)removeTailNode {
    
    if (!_tail) return;
    
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(_tail->_key));
    _totalCost -= _tail->_cost;
    
    if (_head == _tail) {
        
        _head = nil;
        _tail = nil;
    } else {
        
        _tail = _tail->_preNode;
        _tail->_nextNode = nil;
    }
}

- (void)removeAllNodes {
    
    if (!_head) return;
    
    _totalCost = 0;

    _head = nil;
    _tail = nil;
    if (CFDictionaryGetCount(_dic) > 0) {
        
        CFRelease(_dic);

        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
}

@end
