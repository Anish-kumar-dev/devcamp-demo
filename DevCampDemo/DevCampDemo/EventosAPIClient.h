//
//  EventosAPIClient.h
//  DevCampDemo
//
//  Created by Marcelo Fabri on 27/04/13.
//  Copyright (c) 2013 Marcelo Fabri. All rights reserved.
//

#import <AFNetworking.h>

@class Evento;

@interface EventosAPIClient : AFHTTPClient

+ (instancetype)sharedClient;

- (void)getDevCampInfo:(void(^)(Evento *))callback;

@end
