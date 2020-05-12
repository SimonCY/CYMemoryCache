//
//  CYChainTable.h
//  LRUCacheDemo
//
//  Created by chenyan on 2020/5/12.
//  Copyright © 2020 modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CYChainTableNode : NSObject {
    
    @package
    __unsafe_unretained CYChainTableNode *_preNode;
    __unsafe_unretained CYChainTableNode *_nextNode;
    
    id _key;
    id _value;
    NSUInteger _cost;
}
@end



//用于提升访问效率的双向链表
@interface CYChainTable : NSObject {
    
    @package
    CFMutableDictionaryRef _dic;        //用于对节点的引用，防止释放
    CYChainTableNode *_head;
    CYChainTableNode *_tail;
    
    NSInteger _totalCost;
}

//缓存开销
@property (nonatomic, assign, readonly) NSInteger totalCost;
 

- (void)insertNodeAtHead:(CYChainTableNode *)node;

 //用于刷新缓存的访问时序
- (void)bringNodeToHead:(CYChainTableNode *)node;
 
- (void)removeNode:(CYChainTableNode *)node;

 //用于移除最早访问的缓存
- (void)removeTailNode;

- (void)removeAllNodes;

@end


