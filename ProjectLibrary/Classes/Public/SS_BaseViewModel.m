//
//  SS_BaseViewModel.m
//  SchoolSociety
//
//  Created by 邱成西 on 16/8/2.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "SS_BaseViewModel.h"

#import "SZFileManager.h"
#import "RequestServer.h"

@implementation SS_BaseViewModel

- (instancetype)init
{
    if (self = [super init]) {
        _currentPage = 1;
        _pageSize = 10;
        _firstTime = @"0";
        _hasMoreData = NO;
    }
    return self;
}

- (void)loadLastestPage
{
    self.currentPage= 1;
    self.firstTime = @"0";
    self.hasMoreData = NO;
    [self loadItemsWithPageNum:1];
}

- (void)loadNextPage
{
    self.currentPage ++;
    [self loadItemsWithPageNum:self.currentPage];
}

- (void)loadItemsWithPageNum:(NSInteger)pageNum {
    
    if ([AppDelegate shareInstance].interfaceStatus<=0) {
        [RequestServer showAlert:@"暂无网络"];
        return;
    }
}

//读取本地数据
-(void)getCacheDataWithPath:(NSString*)fileName {
    NSArray *array = [SZFileManager readArrayFileToLoginUserPath:fileName];
    
    [self.dataArray addObjectsFromArray:array];
    
    if (array.count>0) {
        if (self.cacheCompletedBlock) {
            self.cacheCompletedBlock(YES,nil);
        }
    }else {
        if (self.cacheCompletedBlock) {
            self.cacheCompletedBlock(NO,nil);
        }
    }
}

#pragma mark -
#pragma mark - getter/setter

-(NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
