//
//  DTMessageSender.m
//  SMSDemo
//
//  Created by David Tseng on 1/29/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//
#import "DTMessageSender.h"


@implementation DTMessageSender

static CancelledBlock cancelledBlock;
static FailedBlock failedBlock;
static SentBlock sentBlock;


+(void)sendMessageTo:(NSArray*)phoneNumbersArray andContent:(NSString*)content andCurrentViewController:(UIViewController*)vw withSent:(SentBlock)sBlock withCancelled:(CancelledBlock)cBlock withFailed:(FailedBlock)fBlock{
    
    [self sendMessageTo:phoneNumbersArray andContent:content andCurrentViewController:vw withSent:sBlock withCancelled:cBlock withFailed:fBlock andCompletion:nil];

}

+(void)sendMessageTo:(NSArray*)phoneNumbersArray andContent:(NSString*)content andCurrentViewController:(UIViewController*)vw withSent:(SentBlock)sBlock withCancelled:(CancelledBlock)cBlock withFailed:(FailedBlock)fBlock andCompletion:(VoidBlock)completeBlock{
    
    if (vw ==nil) {
        return;
    }
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device does not suppport SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    sentBlock = sBlock;
    cancelledBlock = cBlock;
    failedBlock = fBlock;
    
    NSArray *recipents = phoneNumbersArray; //@[@"0910574923"];
    NSString *message = [NSString stringWithString:content];
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = [self class];
    NSLog(@"%@/ %@",self,[self class]);
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [vw presentViewController:messageController animated:YES completion:completeBlock];
}

+ (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            if (cancelledBlock) {
                cancelledBlock(controller);
            }
            break;
            
        case MessageComposeResultFailed:
        {
            if (failedBlock) {
                failedBlock(controller);
            }
            
            break;
        }
            
        case MessageComposeResultSent:
            if (sentBlock) {
                sentBlock(controller);
            }
            break;
            
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:^{
       
    }];
    //[self dismissViewControllerAnimated:YES completion:nil];
}


@end
