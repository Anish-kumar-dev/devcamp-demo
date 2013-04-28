//
//  EventosAPIClient.m
//  DevCampDemo
//
//  Created by Marcelo Fabri on 27/04/13.
//  Copyright (c) 2013 Marcelo Fabri. All rights reserved.
//

#import "EventosAPIClient.h"
#import "Trilha.h"
#import "Evento.h"

@implementation EventosAPIClient

static NSString * const kEventosAPIClientBaseURL = @"https://s3.amazonaws.com/bucket-do-marcelo/";

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    static EventosAPIClient *_sharedClient;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kEventosAPIClientBaseURL]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}

- (void)getDevCampInfo:(void(^)(Evento *))callback {
    [self getPath:@"devcamp.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Evento *evento = [[Evento alloc] init];
        evento.nome = responseObject[@"nome_evento"];
        evento.edicao = responseObject[@"edicao"];
        
        NSMutableArray *trilhas = [NSMutableArray array];
        
        for (NSDictionary *trilhaDict in responseObject[@"trilhas"]) {
            Trilha *trilha = [[Trilha alloc] init];
            
            trilha.nome = trilhaDict[@"nome"];
            trilha.palestrantes = trilhaDict[@"palestrantes"];
            
            [trilhas addObject:trilha];
        }
        evento.trilhas = trilhas;
        
        if (callback) {
            callback(evento);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(nil);
        }
    }];
}
@end
