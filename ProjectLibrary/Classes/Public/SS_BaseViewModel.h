//
//  SS_BaseViewModel.h
//  SchoolSociety
//
//  Created by 邱成西 on 16/8/2.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SZRequestCompletedBlock)(BOOL success,NSString *error);

typedef void(^SZCacheCompletedBlock)(BOOL success,NSString *error);

@interface SS_BaseViewModel : NSObject

//true = 刷新； false ＝ 加载更多
@property (nonatomic, assign) BOOL refresh;

@property (nonatomic, assign) BOOL hasMoreData;
///分页
@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) NSString *firstTime;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) NSMutableArray *dataArray;

//网络请求成功回调
@property(nonatomic,copy)SZRequestCompletedBlock requestCompletedBlock;

///读取本地数据请求回调
@property(nonatomic,copy)SZCacheCompletedBlock cacheCompletedBlock;

- (void)loadLastestPage;//刷新
- (void)loadNextPage;//加载下一页
- (void)loadItemsWithPageNum:(NSInteger)pageNum;

//读取本地数据
-(void)getCacheDataWithPath:(NSString*)fileName;

@end
