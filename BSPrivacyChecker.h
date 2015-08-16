//
//  PrivacyChecker.h
//  
//
//  Created by Kai on 14-8-16.
//  Copyright (c) 2014年 kai.li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSPrivacyChecker : NSObject

+ (void)checkMicPrivacy:(void (^)())successMethod;
+ (BOOL)checkSystemAlbumPrivacy;
+ (BOOL)checkSystemCameraPrivacy;
@end
