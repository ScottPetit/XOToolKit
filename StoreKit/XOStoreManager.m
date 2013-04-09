//
//  XOIAPManager.m
//  The Box Seats
//
//  Created by Scott Petit on 2/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOStoreManager.h"

typedef void (^XOStoreManagerReceiptValidationBlock)(BOOL validated, id receipt);

NSString * const XOStoreManagerProductPurchased = @"XOStoreManagerProductPurchased";
NSString * const XOStoreManagerPurchaseError = @"XOStoreManagerPurchaseError";
NSString * const XOStoreManagerPurchaseCancelled = @"XOStoreManagerPurchaseCancelled";
NSString * const XOStoreManagerReceiptValidationSuccess = @"XOStoreManagerReceiptValidationSuccess";
NSString * const XOStoreManagerReceiptValidationFailure = @"XOStoreManagerReceiptValidationFailure";

@interface XOStoreManager () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, copy) NSSet *productIds;
@property (nonatomic, copy) XOStoreManagerCompletionBlock completionBlock;

@end

@implementation XOStoreManager

- (id)initWithProductIds:(NSSet *)productIds
{
    self = [super init];
    if (self)
    {
        self.productIds = productIds;
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

+ (BOOL)hasStartedSubscription
{
    NSAssert(NO, @"This should be handle by subclasses");
    return NO;
}

+ (BOOL)isSubscriptionActive
{
    NSAssert(NO, @"This should be handle by subclasses");
    return NO;
}

- (void)fetchProductsWithCompletionBlock:(XOStoreManagerCompletionBlock)completion
{
    self.completionBlock = completion;
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:self.productIds];
    request.delegate = self;
    [request start];
}

- (void)purchaseProduct:(SKProduct *)product
{
    if (!product)
    {
        return;
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:product];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)restorePurchases
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (BOOL)hasPurchasedProduct:(SKProduct *)product
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:product.productIdentifier];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:XOStoreManagerPurchaseError object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:XOStoreManagerPurchaseCancelled object:nil];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)validateReceiptForTransaction:(SKPaymentTransaction *)transaction
{
    NSAssert(NO, @"XOStoreManager does not have default support for validating receipts");
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    self.completionBlock(YES, response.products);
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    self.completionBlock(NO, nil);
}

#pragma mark - SKPaymentTransactionObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
            {
                [self validateReceiptForTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateRestored:
            {
                [self validateReceiptForTransaction:transaction];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
