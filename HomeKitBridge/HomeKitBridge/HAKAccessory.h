//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//


#import "HAKServiceDelegate.h"
#import "HAKAccessoryDelegate.h"
#import "HAKAccessoryInformationService.h"

@class HAKAccessoryInformationService, HAKInstanceIDPool, NSArray, NSHashTable, NSMutableArray, NSNumber, NSString;

@interface HAKAccessory : NSObject <NSCopying, NSCoding, HAKServiceDelegate>
{
    NSMutableArray *_services;
    NSNumber *_instanceID;
    HAKInstanceIDPool *_instanceIDPool;
    NSHashTable *_transportRefs;
    HAKAccessoryInformationService *_accessoryInformationService;
    NSObject<OS_dispatch_queue> *_workQueue;
}

@property(retain, nonatomic) NSObject<OS_dispatch_queue> *workQueue; // @synthesize workQueue=_workQueue;
@property(nonatomic) __weak HAKAccessoryInformationService *accessoryInformationService; // @synthesize accessoryInformationService=_accessoryInformationService;
@property(retain, nonatomic) NSHashTable *transportRefs; // @synthesize transportRefs=_transportRefs;
@property(retain, nonatomic) HAKInstanceIDPool *instanceIDPool; // @synthesize instanceIDPool=_instanceIDPool;
@property(retain, nonatomic) NSNumber *instanceID; // @synthesize instanceID=_instanceID;
@property(nonatomic) __weak id <HAKAccessoryDelegate> delegate; // @synthesize delegate=_delegate;
@property(retain, nonatomic) NSArray *services; // @synthesize services=_services;
- (id)serialNumber;
- (id)manufacturer;
- (id)model;
- (id)name;
- (id)serviceWithType:(id)arg1;
- (id)serviceWithInstanceId:(unsigned long long)arg1;
- (void)removeService:(id)arg1;
- (void)addService:(id)arg1;
- (void)removeTransport:(id)arg1;
- (void)addTransport:(id)arg1;
@property(readonly, retain, nonatomic) NSArray *transports;
- (void)_handleUpdatedService:(id)arg1;
- (void)service:(id)arg1 didRemoveCharacteristic:(id)arg2;
- (void)service:(id)arg1 didAddCharacteristic:(id)arg2;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (id)init;
- (id)characteristicWithInstanceId:(unsigned long long)arg1;
- (id)JSONObject;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

