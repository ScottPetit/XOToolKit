//
//  XOIAPManager.h
//  The Box Seats
//
//  Created by Scott Petit on 2/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "XOObject.h"
#import <StoreKit/StoreKit.h>

NSString * const XOStoreManagerProductPurchased;
NSString * const XOStoreManagerPurchaseError;
NSString * const XOStoreManagerPurchaseCancelled;
NSString * const XOStoreManagerReceiptValidationSuccess;
NSString * const XOStoreManagerReceiptValidationFailure;

typedef void (^XOStoreManagerCompletionBlock)(BOOL success, NSArray *products);

@interface XOStoreManager : XOObject

- (id)initWithProductIds:(NSSet *)productIds;
- (void)fetchProductsWithCompletionBlock:(XOStoreManagerCompletionBlock)completion;
- (void)purchaseProduct:(SKProduct *)product;
- (void)restorePurchases;
- (BOOL)hasPurchasedProduct:(SKProduct *)product;

+ (BOOL)hasStartedSubscription;
+ (BOOL)isSubscriptionActive;

- (void)completeTransaction:(SKPaymentTransaction *)transaction;
- (void)restoreTransaction:(SKPaymentTransaction *)transaction;
- (void)failedTransaction:(SKPaymentTransaction *)transaction;

- (void)validateReceiptForTransaction:(SKPaymentTransaction *)transaction;

@end
