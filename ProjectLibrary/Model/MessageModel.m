//
//  MessageModel.m
//  SchoolSociety
//
//  Created by xuyong on 16/8/10.
//  Copyright © 2016年 xuyong. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(NSString *)createTimerStr {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.created];
    return [date formattedDateDescription];
}

+ (NSDictionary*)mts_mapping {
    return  @{
              @"actionUrl": mts_key(actionUrl),
              @"content": mts_key(content),
              @"created": mts_key(created),
              @"mId": mts_key(mId),
              @"receiverUid": mts_key(receiverUid),
              @"sender": mts_key(sender),
              @"senderUid": mts_key(senderUid)
              };
}

+ (BOOL)mts_shouldSetUndefinedKeys {
    return NO;
}

#pragma mark - NSCoding
-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.actionUrl       = [decoder decodeObjectForKey:@"actionUrl"];
        self.content       = [decoder decodeObjectForKey:@"content"];
        self.created         = [decoder decodeDoubleForKey:@"created"];
        self.mId       = [decoder decodeIntForKey:@"mId"];
        self.receiverUid       = [decoder decodeIntForKey:@"receiverUid"];
        self.sender       = [decoder decodeObjectForKey:@"sender"];
        self.senderUid       = [decoder decodeIntForKey:@"senderUid"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.actionUrl forKey:@"actionUrl"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeInt:(int)self.created forKey:@"created"];
    [encoder encodeInt:(int)self.mId forKey:@"mId"];
    [encoder encodeInt:(int)self.receiverUid forKey:@"receiverUid"];
    [encoder encodeInt:(int)self.senderUid forKey:@"senderUid"];
    [encoder encodeObject:self.sender forKey:@"sender"];
    
}


+ (NSDictionary*)mts_arrayClassMapping
{
    return @{
             mts_key(sender) : UserInfoModel.class,
             };
}
@end
