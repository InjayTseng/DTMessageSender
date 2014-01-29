//
//  DTMessageSender.h
//  SMSDemo
//
//  Created by David Tseng on 1/29/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

typedef void (^VoidBlock)();
typedef void (^CancelledBlock)(MFMessageComposeViewController *controller);
typedef void (^FailedBlock)(MFMessageComposeViewController *controller);
typedef void (^SentBlock)(MFMessageComposeViewController *controller);

@interface DTMessageSender : NSObject<MFMessageComposeViewControllerDelegate>

+(void)sendMessageTo:(NSArray*)phoneNumbersArray andContent:(NSString*)content andCurrentViewController:(UIViewController*)vw withSent:(SentBlock)sBlock withCancelled:(CancelledBlock)cBlock withFailed:(FailedBlock)fBlock;

+(void)sendMessageTo:(NSArray*)phoneNumbersArray andContent:(NSString*)content andCurrentViewController:(UIViewController*)vw withSent:(SentBlock)sBlock withCancelled:(CancelledBlock)cBlock withFailed:(FailedBlock)fBlock andCompletion:(VoidBlock)completeBlock;

@end

