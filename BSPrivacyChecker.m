//
//  PrivacyChecker.m
//  
//
//  Created by Kai on 14-8-16.
//  Copyright (c) 2014年 Kai.Li. All rights reserved.
//
#import "BSPrivacyChecker.h"

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioSession.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>


@implementation BSPrivacyChecker

+ (CGFloat)iosVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (void)checkMicPrivacy:(void (^)())successMethod
{
    static long lastalerttime = 0;
    if([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)])
    {
        //requestRecordPermission
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (!granted) {
                long delta = [NSDate date].timeIntervalSince1970 - lastalerttime;
                if (delta > 300) {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"麦克风被禁用\n对方无法听到声音"
                                          message:@"请在iPhone的\"设置-隐私-麦克风\"中设置允许访问你的麦克风！"
                                          delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
                    
                    [alert show];
                    lastalerttime = [NSDate date].timeIntervalSince1970;
                }
            } else {
                successMethod();
            }
        }];
        
    } else {
        successMethod();
    }
}

+ (BOOL)checkSystemAlbumPrivacy
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
        case ALAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:@"请在iPhone的\"设置-通用-访问限制-相册\"选项中，设置允许访问你的相册！"
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        case ALAuthorizationStatusDenied:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:@"请在iPhone的\"设置-隐私-相册\"选项中，设置允许访问你的相册！"
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
        }
        case ALAuthorizationStatusNotDetermined:
        case ALAuthorizationStatusAuthorized:
            return YES;
        default:
            return YES;
    }
}

+ (BOOL)checkSystemCameraPrivacy
{
    if ([BSPrivacyChecker iosVersion] < 7.0) {
        return YES;
    }
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:@"请在iPhone的\"设置-通用-访问限制-相机\"选项中，设置允许访问你的相机！"
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        case AVAuthorizationStatusDenied:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:@"请在iPhone的\"设置-隐私-相机\"选项中，设置允许访问你的相机"
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        case AVAuthorizationStatusAuthorized:
        case AVAuthorizationStatusNotDetermined:
            return YES;
        default:
            return YES;
    }
}

@end
